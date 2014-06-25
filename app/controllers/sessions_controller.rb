class SessionsController < ApplicationController

  before_filter :require_signed_out!, :only => [:home, :new]

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
      redirect_to feed_all_url
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
