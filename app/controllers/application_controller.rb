class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".danger"
      redirect_to login_url
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:danger] = t ".not_found"
  end

  def verify_user
    @user = User.find_by id: params[:id]
    flash[:danger] = t ".verify_user"
    redirect_to root_url unless @user.current_user? current_user
  end

end
