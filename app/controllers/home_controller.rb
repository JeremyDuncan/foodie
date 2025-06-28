class HomeController < ApplicationController

  # GET /users or /users.json
  def index
    @users = User.all
  end

  def root
    if user_signed_in?
      @users = User.all
      render :index
    else
      redirect_to new_user_session_path
    end
  end

end
