class SessionsController < ApplicationController
  def offline_login
    self.current_user = User.find_by_nickname(params[:nickname])

    redirect_to root_path, notice: "Offline Login!"
  end

  def create
    self.current_user = User.handle_authorization(request.env['omniauth.auth'])

    cookies.permanent.signed[:remember_me] = [current_user.id, current_user.salt]

    path = request.env['omniauth.origin'] || root_path
    redirect_to path, notice: "Hi #{current_user.nickname}, welcome back!"
  end

  def destroy
    message = flash[:notice] || "Bye #{current_user.nickname}, come back soon!"

    cookies.permanent.signed[:remember_me] = ['', '']
    session[:user_id] = nil

    redirect_to root_path, notice: message
  end

  def failure
    redirect_to root_path, alert: "Ups, we have an issue with your login!"
  end
end
