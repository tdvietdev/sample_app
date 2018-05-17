class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t "sessions.create.danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def new
  end

end
