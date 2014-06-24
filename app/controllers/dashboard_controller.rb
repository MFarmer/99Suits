class DashboardController < ApplicationController

  def feed_all
    @items = Item.all
  end

  def feed_sale
    @items = Item.where("sale_price IS NOT ?", nil)
  end

  def feed_trade
    @items = Item.where("trade_price IS NOT ?", nil)
  end

end
