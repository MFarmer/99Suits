class OrdersController < ApplicationController

  before_filter :require_signed_in!

  def new
    @order = current_user.orders.new
    @order.item_id = params[:item_id]

    @item = Item.find(params[:item_id])
  end

end
