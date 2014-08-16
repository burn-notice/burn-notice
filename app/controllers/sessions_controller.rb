class SessionsController < ApplicationController
  def create
    path = request.env['omniauth.origin'] || notices_path
    auth = request.env['omniauth.auth'].slice('provider', 'uid', 'info')
    if authorization = Authorization.find_by_provider_and_uid(auth['provider'], auth['uid'])
      sign_in(authorization.user)
      redirect_to path, notice: "Hi #{authorization.user.nickname}, welcome back!"
    else
      session[:auth_path] = path
      session[:auth_data] = auth
      redirect_to signup_path
    end
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
end
