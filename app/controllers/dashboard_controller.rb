class DashboardController < ApplicationController

  before_filter :require_signed_in!

  def account_profile
  end

  def account_reports

  end

  def account_feedback

  end

  def account_available

  end

  def account_received

  end

  def account_gone

  end

  def account_ship

  end

  def account_pickup

  end

  def account_pending_feedback

  end

  def account_on_the_way

  end

  def account_leave_feedback

  end

  def feed_all
    @items = Item.all
  end

  def feed_sale
    @items = Item.where("sale_price IS NOT ?", nil)
  end

  def feed_trade
    @items = Item.where("trade_price IS NOT ?", nil)
  end

  def discover_people
    @users = User.all
  end

  def discover_items
    @items = Item.all
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
