# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, :user_deleted_state, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected

  def user_state
    @user = User.find_by(email: params[:user][:email])
    if !@user
      flash[:danger1] = "メールアドレスに誤りがあります。"
      if params[:user][:password] == ""
        flash[:danger2] = "パスワードに誤りがあります。"
      end
      return
    else
      flash[:danger1] = ""
    end
    if params[:user][:password] != "" && @user.valid_password?(params[:user][:password])
      if @user.is_deleted
        redirect_to new_user_registration_path
      end
    else
      flash[:danger2] = "パスワードに誤りがあります。"
    end

  end

  def user_deleted_state
  @user = User.find_by(email: params[:user][:email])
  return if !@user
  if @user.valid_password?(params[:user][:password]) && @user.is_deleted
    redirect_to new_user_registration_path
  end
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to choose_knowledges_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end
