# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

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
  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    root_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end
  
  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if (@user.valid_password?(params[:user][:encrypted_password]) && (@user.is_deleted == true))
      redirect_to new_user_registration_path
    end
  end
  
  # ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = "ゲストログインしました"
    redirect_to root_path
  end
  
end
