class OrdersController < ApplicationController

  before_filter :require_signed_in!

  def new
    @order = current_user.orders.new
    @order.item_id = params[:item_id]

    @item = Item.find(params[:item_id])
  end

  def create
    @order = current_user.orders.new(order_params)

    @item = Item.find(params[:item_id])
    @order.item_id = @item.id


    if @order.save
      flash.now[:notice] = "Successfully created order."
      redirect_to feed_all_url
    else
      flash.now[:errors] = @order.errors.full_messages
      render :new
    end

  end

  def mark_as_shipped
    order = Order.find(params[:id])
    order.shipping_date = Time.zone.now
    order.save!
    redirect_to account_gone_url
  end

  private

  def order_params
    params.require(:order).permit(:street, :city, :state, :zip, :purchase_type)
  end

end
