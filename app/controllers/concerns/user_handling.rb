module UserHandling
  extend ActiveSupport::Concern

  protected

  def authenticate!
    unless signed_in?
      redirect_to login_path, alert: t('session.not_logged_in')
    end
  end

  def authenticate_current_user!
    unless signed_in? && current_user?
      redirect_to login_path, alert: t('session.not_proper_account')
    end
  end

  def current_user?
    current_user == user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
    cookies.permanent.signed[:remember_me] = [user.id, user.salt]
  end
  alias_method :sign_in, :current_user=

  def sign_out
    session[:user_id] = nil
    cookies.permanent.signed[:remember_me] = ['', '']
  end
end
