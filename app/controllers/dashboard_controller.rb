class DashboardController < ApplicationController

  before_filter :require_signed_in!

  def account_profile
  end

  def discover
    @search_results = PgSearch.multisearch(params[:query])
  end

  def activity
    fail
  end

  def account_reports
  end

  def account_feedback
    @feedback = current_user.feedbacks
  end

  # Items which have not been ordered
  def account_hidden
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.hidden = true").includes(:user)
  end

  def account_available
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.user_id = #{current_user.id} AND items.hidden = false")
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
    @orders = Order.where("user_id = ? AND shipping_date IS ?", current_user.id, nil).includes(:item)
  end

  def account_leave_feedback
    @orders = Order.joins("LEFT OUTER JOIN feedbacks ON orders.id = feedbacks.order_id WHERE feedbacks.order_id IS NULL AND orders.user_id = #{current_user.id} AND orders.shipping_date IS NOT NULL")
  end

  def feed_all
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.hidden = false").includes(:user)
  end

  def feed_sale
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE
 orders.item_id IS NULL AND items.sale_price IS NOT NULL AND items.hidden = false").includes(:user)
  end

  def feed_trade
    @items = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE
 orders.item_id IS NULL AND items.trade_price IS NOT NULL AND items.hidden = false").includes(:user)
  end

  def featured_staff_picks
    @items = Item.where("staff_pick = ?", true)
  end

  def featured_most_liked
    result = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.hidden = false").includes(:user)

    @items = []
    result.each do |item|
      if item.like_count > 0
        @items << item
      end
      if @items.count >= 8
        break
      end
    end

    @items.sort! { |a, b| b.like_count <=> a.like_count }

    @items
  end

  def featured_most_commented
    result = Item.joins("LEFT OUTER JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL AND items.hidden = false").includes(:comments)

    @items = []
    result.each do |item|
      if item.comments.count > 0
        @items << item
      end
      if @items.count >= 8
        break
      end
    end

    @items.sort! { |a, b| b.comments.count <=> a.comments.count }

    @items
  end

  def featured_most_active
    result = User.all.includes(:items)

    @users = []
    result.each do |user|
      if user.items.count > 0
        @users << user
      end
      if @users.count >= 8
        break
      end
    end

    @users.sort! { |a, b| b.items.count <=> a.items.count }

    @users
  end

  def featured_newest_users
    @newest_users = User.all.order('created_at DESC LIMIT 10')
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
