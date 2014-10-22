class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth'].slice('provider', 'uid', 'info')
    if authorization = Authorization.find_by_provider_and_uid(auth['provider'], auth['uid'])
      sign_in(authorization.user)
      redirect_to notices_path, notice: "Hi #{authorization.user.nickname}, welcome back!"
    elsif signed_in?
      current_user.authorizations.create! provider: auth['provider'], uid: auth['uid']
      redirect_to user_path(current_user), notice: "Connected your account to #{auth['provider']}!"
    else
      session[:auth_path] = notices_path
      session[:auth_data] = auth
      redirect_to signup_path
    end
  end

  def validation
    user = User.find_by_token(params[:token])
    user.validate!

    redirect_to notices_path, notice: "Your validation was successful!"
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
    session.destroy
    user = User.find_by_nickname(params[:nickname])
    sign_in(user)

    redirect_to user_path(user), notice: "Offline Login for #{user.nickname}!"
  end

  def email
    if params[:email].present?
      session[:email_auth_address] = params[:email]
      session[:email_auth_token] = SecureRandom.uuid
      mail = UserMailer.email_auth(params[:email], session[:email_auth_token])
      MailerJob.new.async.deliver(mail)
    end
  end

  def signup
    @auth = session[:auth_data]
    email = @auth['info']['email'].blank? ? session.delete(:beta_user_email) : @auth['info']['email']
    check_existing_user(email)
    @user = User.new(nickname: @auth['info']['nickname'], email: email)
  end

  def complete
    @auth = session[:auth_data]
    user_params = params.require(:user).permit!
    if session[:email_auth_address]
      user_params[:email] = session[:email_auth_address]
      user_params[:validation_date] = Time.now
    end
    @user = User.new(user_params)
    @user.authorizations.build provider: @auth['provider'], uid: @auth['uid']
    if @user.save
      session.delete(:auth_data)
      unless @user.validated?
        mail = UserMailer.signup(@user)
        MailerJob.new.async.deliver(mail)
      end
      sign_in(@user)
      redirect_to session.delete(:auth_path), notice: "Hi #{@user.nickname}, welcome to Burn-Notice!"
    else
      check_existing_user(params[:user][:email])
      render :signup
    end
  end

  private

  def check_existing_user(email)
    if existing_user = User.find_by_email(email)
      providers = existing_user.authorizations.map(&:provider)
      flash.now[:alert] = "An existing user was found for #{email}, please sign in through #{providers.to_sentence}!"
    end
  end
end
