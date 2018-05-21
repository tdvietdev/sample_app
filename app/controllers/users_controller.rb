class UsersController < ApplicationController
  before_action :load_user, except: :index
  before_action :logged_in_user, only: %i(new create)
  before_action :verify_user, only: %i(edit update)
  before_action :verify_admin, only: :destroy

  def index
    @users = User.list_user.page(params[:page]).per Settings.users.index.per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "users.create.success"
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to users_path
  end

  def edit; end

  def new
    @user = User.new
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :edit
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".danger"
      redirect_to login_url
    end
  end

  def verify_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user.current_user? current_user
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to users_path
  end
end
