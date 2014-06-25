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
  end

  def update
    @user = User.find(params[:id])

    # Did the user want to change password?
    if !params[:password].nil?

      # If current password is correct and new password matches confirmation password...
      if @user.is_password?(params[:current_password]) && params[:password] == params[:password_confirmation]

        if @user.update(user_params)
          flash[:notice] = "Successfully updated profile."
        else
          flash.now[:errors] = @user.errors.full_messages
        end

      else
        flash.now[:errors] = ["Either the current password is invalid, or the new passwords did not match."]
        redirect_to account_profile_url
      end

    else

      # User did not want to update password
      if @user.update(fname: user_params[:fname],
                      lname: user_params[:lname],
                      avatar: user_params[:avatar],
                      username: user_params[:username],
                      email: user_params[:email])

        flash[:notice] = "Successfully updated profile."
      else
        flash.now[:errors] = @user.errors.full_messages
      end

    end

    redirect_to account_profile_url

  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :avatar, :username, :email,
                                 :password, :token)
  end

end
