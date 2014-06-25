class DashboardController < ApplicationController

  before_filter :require_signed_in!

  def feed_all
    @items = Item.all
  end

  def feed_sale
    @items = Item.where("sale_price IS NOT ?", nil)
  end

  def feed_trade
    @items = Item.where("trade_price IS NOT ?", nil)
  end

  def profile_items_available
    @items = Item.where("user_id = ?", params[:id])
  end

  def profile_items_sold
    @items = Item.where("user_id = ?", params[:id])
  end

  def profile_items_traded
    @items = Item.where("user_id = ?", params[:id])
  end

end
