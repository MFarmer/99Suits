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

    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
          :amount => (@item.sale_price * 100).floor,
          :currency => "usd",
          :card => token
      )

      flash.now[:notice] = "Thanks for ordering!"
    rescue Stripe::CardError => e
      flash.now[:danger] = e.message
    end

    if @order.save
      redirect_to order_confirmation_url(@order.id)
    else
      flash.now[:errors] = @order.errors.full_messages
      render :new
    end

  end

  def confirmation
    @order = Order.find(params[:id])
  end

  def mark_as_shipped
    order = Order.find(params[:id])
    order.shipping_date = Time.zone.now
    order.save!
    redirect_to account_gone_url
  end

  private

  def order_params
    params.require(:order).permit(:street, :city, :state, :zip, :purchase_type, :shipping_type)
  end

end
