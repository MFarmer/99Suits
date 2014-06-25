class ItemsController < ApplicationController

  before_filter :require_signed_in!

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

end
