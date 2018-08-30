class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:root]

  def root
  end

  def dashboard
    @messages = [] # from distributor, from admin
    @tags = Tag.all.order(:code)
    @recents = current_user.recent_products
  end

  def users
    if user_signed_in?
      if current_user.admin?
        @users = User.all
      else
        @users = current_user.children
      end
    else
      render status: 403
    end
  end
end
