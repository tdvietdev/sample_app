class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ?
          remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t "sessions.create.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def new
    redirect_to @current_user if logged_in?
  end

end
