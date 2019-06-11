# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    parent = User.parent_by_token(params[:token])
    pa = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.new(pa)
    @user.parent = parent
    respond_to do |format|
      if parent.nil?
        flash[:warning] = "ディストリビュータIDが正しくありません"
        format.html { render :new }
      elsif @user.save
        format.html { redirect_to root_path, notice: t('devise.registrations.user.signed_up_but_unconfirmed') }
      else
        format.html { render :new }
      end
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:message4payment,:paypal_id,:address, :birthdate, :phone_no, :memo])
  end
end
