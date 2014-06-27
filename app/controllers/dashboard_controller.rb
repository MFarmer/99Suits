class DashboardController < ApplicationController

  before_filter :require_signed_in!

  def account_profile
  end

  def account_reports
    orders_within_last_week = Order.where("user_id = ? AND created_at > ?", params[:id], 1.week.ago)

    order_map = Hash.new(0)
    orders_within_last_week.each do |order|
      order_map[order.created_at.day] += 1
    end

    #@orders_data = {7.days.ago => 5, 6.days.ago => 3, 5.days.ago => 4, 4.days.ago => 7, 3.days.ago => 4, 2.days.ago => 2, 1.day.ago => 3}

    @purchases_data = @orders_data
  end

  def account_feedback
    @feedback = current_user.feedbacks
  end

  # Items which have not been ordered
  def account_hidden
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.hidden = true").includes(:user)
  end

  def account_available
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.user_id = #{current_user.id} AND items.hidden IS NULL OR items.hidden = false")
  end

  # Items which current user ordered and have shipped
  def account_received
    @items = Item.joins(:order).where('orders.user_id = ? AND orders.shipping_date IS NOT ?', current_user.id, nil)
  end

  # Items which current user is seller and item has shipped
  def account_gone
    @items = Item.joins(:order).where('items.user_id = ? AND orders.shipping_date IS NOT ?', current_user.id, nil)
  end

  # All Items which current user has sold but not yet shipped
  def account_ship
    @items = Item.joins(:order).where('items.user_id = ? AND orders.shipping_date IS ? AND orders.shipping_type = ?', current_user.id, nil, "Ship")
  end

  def account_pickup
    @items = Item.joins(:order).where('items.user_id = ? AND orders.shipping_date IS ? AND orders.shipping_type = ?', current_user.id, nil, "Pickup")
  end

  # Items current user sold and have shipped AND have not received feedbacks [TODO]
  def account_pending_feedback
    @items = Item.joins(:order).where('items.user_id = ? AND orders.shipping_date IS NOT ? AND ', current_user.id, nil)
  end

  # Items current user has purchased and have not yet shipped
  def account_on_the_way
    @items = Item.joins(:order).where('orders.user_id = ? AND orders.shipping_date IS ?', current_user.id, nil)
  end

  def account_leave_feedback
    @orders = Order.joins("LEFT OUTER JOIN feedbacks ON orders.id = feedbacks.order_id WHERE feedbacks.order_id IS NULL AND orders.user_id = #{current_user.id} AND orders.shipping_date IS NOT NULL")
  end

  def feed_all
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.hidden IS NULL OR items.hidden = false").includes(:user)
    #@items = Item.all
  end

  def feed_sale
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE
 orders.item_id IS NULL AND items.sale_price IS NOT NULL AND items.hidden IS NULL OR items.hidden = false").includes(:user)
  end

  def feed_trade
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE
 orders.item_id IS NULL AND items.trade_price IS NOT NULL AND items.hidden IS NULL OR items.hidden = false").includes(:user)
  end

  def discover_people
    @users = User.all
  end

  def discover_items

  end

  def activity

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
