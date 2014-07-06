class ItemsController < ApplicationController

  before_filter :require_signed_in!
  before_filter :require_not_sold!, :require_visible!, :only => :show

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)

    if @item.save
      flash.now[:notice] = "Successfully created item."
      redirect_to feed_all_url
    else
      flash.now[:errors] = @item.errors.full_messages
      render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.hidden = true

    @item.save!
    flash.now[:notice] = "Successfully removed #{@item.title} from listings. You can re-list the item here."
    redirect_to account_available_url
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      flash.now[:notice] = "Successfully updated the item."
      redirect_to item_url(@item.id)
    else
      flash.now[:errors] = @item.errors.full_messages
    end
  end

  def show
    @item = Item.find(params[:id])
    @comments = @item.comments
    @like_count = @item.likes.count
    @item_liked_by_user = (Like.where("user_id = ? AND item_id = ?", current_user.id, @item.id).count > 0)
  end

  def like
    like = Like.new(user_id: current_user.id, item_id: params[:id])
    if like.save
      flash[:notice] = "Item was liked!"
    else
      flash[:errors] = "Unable to like the item."
    end
    redirect_to item_url(params[:id])
  end

  def staff_pick
    item = Item.find(params[:id])
    if current_user.staff
      item.update(staff_pick: true);
    end
    redirect_to item_url(item.id)
  end

  def relist
    @item = Item.find(params[:id])
    @item.hidden = false
    @item.save!
    flash[:success] = "Successfully re-listed item."
    redirect_to account_hidden_url
  end

  private

  def item_params
    params.require(:item).permit(:title, :brand, :category, :photo, :condition, :original_price, :description,
                                 :sale_price, :trade_price, :allow_pickup, :weight, :user_id, :size)
  end

  def require_not_sold!
    if Order.where("item_id = ?", params[:id]).count > 0
      flash.now[:errors] = ["Sorry, the item is no longer available."]
      redirect_to feed_all_url
    end
  end

  def require_visible!
    @item = Item.find(params[:id])
    if @item.hidden
      flash[:errors] = ["Sorry, this item is no longer available from the seller."]
      redirect_to feed_all_url
    end
  end

end
