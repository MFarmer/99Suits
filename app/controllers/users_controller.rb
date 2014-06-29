class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to feed_all_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    user_summary_prep
  end

  def update
    #fail
    @user = User.find(params[:id])

    # Password being changed?
    if params[:password]
      if @user.is_password?(params[:current_password]) && params[:password] == params[:password_confirmation]
        @user.password = params[:password]
      end
    end

    @user.update(user_params)

    redirect_to account_profile_url

  end

  def follow
    follow = current_user.follows.new(user_id: current_user.id, following_id: params[:id])
    follow.save!
    redirect_to user_url(params[:id])
  end

  def feedback
    # Setup all instance variables required to populate data in the user summary table
    user_summary_prep

    # Do feedback specific processing
    orders = Order.joins(:item).where('items.user_id = ? AND orders.shipping_date IS NOT ?', @user.id, nil).includes(:feedback).includes(:buyer)

    @rating = 0
    count = 0
    @feedback = []
    orders.each do |order|
      if order.feedback
        @feedback << order.feedback
        @rating += order.feedback.rating
        count += 1
      end
    end

    if count > 0
      @rating /= count
    end

  end

  def following
    user_summary_prep
  end

  def followers
    user_summary_prep
  end

  private

  def user_summary_prep
    @user = User.find(params[:id])
    @transactions_count = @user.orders.count + @user.items.count
    @followed_users = Follow.where('user_id = ?', @user.id)
    @followed_by = Follow.where('following_id = ?', @user.id)
    @shipped_orders = Order.joins(:item).where('items.user_id = ? AND orders.shipping_date IS NOT ?', @user.id, nil).includes(:feedback)

    @items = Item.joins("LEFT JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL
                          AND items.user_id = #{@user.id} AND items.hidden = false")
  end

  def user_params
    params.require(:user).permit(:fname, :lname, :avatar, :username, :email, :city, :state, :bio,
                                 :password, :token)
  end

end
