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
    @user = User.find(params[:user_id])
    @item = @user.items.new(item_params)

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
  end

  def like
    like = Like.new(user_id: current_user.id, item_id: params[:id])
    if like.save
      flash.now[:notice] = "Item was liked!"
    else
      flash.now[:errors] = "Unable to like the item."
    end
    redirect_to item_url(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:title, :brand, :category, :photo, :condition, :original_price, :description,
                                 :sale_price, :trade_price, :allow_pickup, :weight, :size)
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
      flash.now[:errors] = ["Sorry, this item is no longer available from the seller."]
      redirect_to feed_all_url
    end
  end

end
