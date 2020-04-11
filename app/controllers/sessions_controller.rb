class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    if User.all.count > 0
      user = User.find_by(name: params[:name])
      if user.try(:authenticate, params[:password])
        session[:user_id] = user.id
        redirect_to admin_url
      else
        redirect_to login_url, alert: "Invalid user/password combination"
      end
    else
      user = User.new
      user.name = params[:name]
      user.password = params[:password]
      user.password_confirmation = params[:password]
      user.save
      session[:user_id] = user.id
      redirect_to admin_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out"
  end
end
