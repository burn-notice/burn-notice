class SessionsController < ApplicationController

  before_action :set_auth, only: [:complete, :ticket, :signup]

  def create
    auth = request.env['omniauth.auth'].slice('provider', 'uid', 'info')
    if authorization = Authorization.find_by_provider_and_uid(auth['provider'], auth['uid'])
      sign_in(authorization.user)
      redirect_to notices_path, notice: t('sessions.welcome_back', nickname: authorization.user.nickname)
    elsif signed_in?
      current_user.authorizations.create! provider: auth['provider'], uid: auth['uid']
      redirect_to user_path(current_user), notice: t('sessions.connected', provider: auth['provider'].humanize)
    else
      session[:auth_path] = notices_path
      session[:auth_data] = auth
      redirect_to auth['provider'] == 'email' ? ticket_path : signup_path
    end
  end

  def validation
    user = User.find_by_token(params[:token])
    user.validate!

    redirect_to notices_path, notice: t('sessions.validation_successful')
  end

  def destroy
    sign_out if signed_in?

    redirect_to root_path, notice: flash[:notice] || t('sessions.bye')
  end

  def failure
    redirect_to root_path, alert: t('sessions.ups_something_went_wrong')
  end

  def offline_login
    session.destroy
    user = User.find_by_nickname!(params[:nickname])
    sign_in(user)

    redirect_to user_path(user), notice: "Offline Login for #{user.nickname}!"
  end

  def email
    if params[:email].present?
      session[:email_auth_address] = params[:email]
      session[:email_auth_token] = SecureRandom.uuid
      mail = UserMailer.email_auth(params[:email], session[:email_auth_token])
      MailerJob.perform_async(mail, I18n.locale)
    end
  end

  def signup
    email = @auth['info']['email']
    check_existing_user(email)
    @user = User.new(nickname: @auth['info']['nickname'], email: email)
  end

  def ticket
    email = @auth['info']['email']
    if check_existing_user(email)
      render :email
    else
      @user = User.new(
        {
          email:            email,
          nickname:         email.gsub(/@.*/, ''),
          validation_date:  Time.now,
        }
      )
      @user.authorizations.build provider: @auth['provider'], uid: @auth['uid']
      @user.save
      sign_in(@user)

      session.delete(:auth_data)
      redirect_to session.delete(:auth_path), notice: t('sessions.welcome', nickname: @user.nickname)
    end
  end

  def complete
    user_params = params.require(:user).permit!
    if session[:email_auth_address]
      user_params[:email] = session[:email_auth_address]
      user_params[:validation_date] = Time.now
    end
    @user = User.new(user_params)
    @user.authorizations.build provider: @auth['provider'], uid: @auth['uid']

    if @user.save
      session.delete(:auth_data)
      mail = UserMailer.signup(@user)
      MailerJob.perform_async(mail, I18n.locale)
      sign_in(@user)
      redirect_to session.delete(:auth_path), notice: t('sessions.welcome', nickname: @user.nickname)
    else
      check_existing_user(params[:user][:email])
      render :signup
    end
  end

  private

  def set_auth
    @auth = session[:auth_data]
    _404("no auth available in session") if @auth.blank?
  end

  def check_existing_user(email)
    if existing_user = User.find_by_email(email)
      providers = existing_user.authorizations.map(&:provider)
      flash.now[:alert] = t('sessions.existing_user', email: email, providers: providers.to_sentence)
    end
  end
end
