class SessionsController < ApplicationController
  def create
    user = User.handle_authorization(request.env['omniauth.auth'])
    sign_in(user)

    path = request.env['omniauth.origin'] || root_path
    redirect_to path, notice: "Hi #{user.nickname}, welcome back!"
  end

  def validation
    user = User.find_by_token(params[:token])
    user.valid!

    redirect_to root_path, notice: "Thank's, your validation was successful!"
  end

  def destroy
    message = flash[:notice] || "Bye #{current_user.nickname}, come back soon!"

    sign_out

    redirect_to root_path, notice: message
  end

  def failure
    redirect_to root_path, alert: "Ups, we have an issue with your login!"
  end

  def offline_login
    user = User.find_by_nickname(params[:nickname])
    sign_in(user)

    redirect_to root_path, notice: "Offline Login!"
  end

  private

  def sign_in(user)
    self.current_user = user
    cookies.permanent.signed[:remember_me] = [user.id, user.salt]
  end

  def sign_out
    session[:user_id] = nil
    cookies.permanent.signed[:remember_me] = ['', '']
  end
end
