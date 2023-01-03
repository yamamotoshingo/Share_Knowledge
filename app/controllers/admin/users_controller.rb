class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:search]
      @users = User.where("nickname LIKE ?",'%' + params[:search] + '%').page(params[:page]).per(10)
    else
      @users = User.all.page(params[:page]).per(10)
    end
  end

  def destroy
    @users = User.where(id: params[:user])
    @users.destroy_all
    redirect_to admin_users_path
  end

  def withdrawal
    if params[:user]
      @user = User.find(params[:user].to_i)
      @user.update_attribute(:is_deleted, true)
      redirect_to admin_users_path
    else
      @users = User.where(id: params[:alluser].split(","))
      @users.update_all(is_deleted: true)
      redirect_to admin_users_path
    end
  end

  def lift
    if params[:user]
      @user = User.find(params[:user].to_i)
      @user.update_attribute(:is_deleted, false)
      redirect_to admin_users_path
    else
      @users = User.where(id: params[:alluser].split(","))
      @users.update_all(is_deleted: false)
      redirect_to admin_users_path
    end
  end
end
