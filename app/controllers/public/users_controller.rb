class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @knowledges = current_user.knowledges.page(params[:page]).per(10)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      sign_in(current_user, bypass: true)
      redirect_to users_path
    else
      @knowledges = current_user.knowledges.page(params[:page]).per(10)
      render :show
    end
  end

  def withdrawal
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
