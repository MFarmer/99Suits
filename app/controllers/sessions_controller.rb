class SessionsController < ApplicationController

  def home

  end

  def new
  end

  def create
    user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
    )

    if user
      sign_in(user)
      redirect_to items_url
    else
      flash.now[:errors] = ["Invalid credentials. Please try again."]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
