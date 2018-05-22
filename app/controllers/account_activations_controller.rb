class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activated
      log_in user
      flash[:success] = t ".success"
      redirect_to user
    else
      flash[:danger] = t ".danger_active"
      redirect_to root_url
    end
  end
end