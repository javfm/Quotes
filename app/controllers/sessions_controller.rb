class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = 'Successfull log in'
      redirect_to user
    else
      flash.now[:alert] = 'Invalid email or password'
      render 'new'
    end
  end

  def new

  end

  def destroy
    log_out
    redirect_to root_url
  end
end
