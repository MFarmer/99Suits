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
      redirect_to items_url
    else
      flash.now[:errors] = @item.errors.full_messages
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :brand, :category, :condition, :original_price, :description,
                                 :sale_price, :trade_price, :allow_pickup, :weight, :size)
  end

end
