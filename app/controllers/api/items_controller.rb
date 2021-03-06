class Api::ItemsController < ApplicationController

  def index
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.hidden = false").includes(:user)

    render "items/index"
  end

  def sale
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE
 orders.item_id IS NULL AND items.sale_price IS NOT NULL AND items.hidden = false").includes(:user)

    render "items/index"
  end

  def trade
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE
 orders.item_id IS NULL AND items.trade_price IS NOT NULL AND items.hidden = false").includes(:user)

    render "items/index"
  end

  def like
    if Like.where("user_id = ? AND item_id = ?", current_user.id, params[:id]).count == 0
      like = Like.new(user_id: current_user.id, item_id: params[:id])
      like.save
      item = Item.find(params[:id])
      render :json => item.likes.count
    else
      render :json => item.likes.count
    end
  end

  def view
    item = Item.find(params[:id])
    item.views += 1
    item.save
    render :json => item.views
  end

  def staff_pick
    item = Item.find(params[:id])
    item.staff_pick = true
    item.save
    render :json => item
  end

  def show
    @item = Item.find(params[:id])
    render "items/show"
    #render :json => @item
  end

  def create
    @item = current_user.items.new(item_params)

    if @item.save
      render :json => @item
    else
      render :json => @item.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      render :json => @item
    else
      raise "Error in Item Destroy Action"
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :brand, :category, :photo, :condition, :original_price, :description,
                                 :sale_price, :trade_price, :allow_pickup, :weight, :user_id, :size)
  end

end
