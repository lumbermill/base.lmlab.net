class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:about, :root]

  def about
  end

  def root
  end

  def dashboard
    @messages = [] # from distributor, from admin
    @histories = [] # TODO:
  end

  def users
    if user_signed_in?
      if current_user.admin?
        @users = User.all
      else
        render status: 403
      end
    else
      render status: 403
    end
  end
end
