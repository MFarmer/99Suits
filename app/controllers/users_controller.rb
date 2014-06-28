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
    @user = User.find(params[:id])
    @items = Item.joins("LEFT JOIN orders ON orders.item_id = items.id WHERE orders.item_id IS NULL
                          AND items.user_id = #{@user.id} AND items.hidden = false")
  end

  def update
    @user = User.find(params[:id])

    # Password being changed?
    if params[:password]
      if @user.is_password?(params[:current_password]) && params[:password] == params[:password_confirmation]
        @user.password = params[:password]
      end
    end

    if @user.update(user_params)
      flash[:notice] = "Successfully updated profile."
    else
      flash[:errors] = @user.errors.full_messages
    end

    redirect_to account_profile_url

  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :avatar, :username, :email, :city, :state, :bio,
                                 :password, :token)
  end

end
