module UserHandling
  extend ActiveSupport::Concern

  protected

  def authenticate!
    unless signed_in?
      redirect_to root_path, alert: t("flash.not_authenticated")
    end
  end

  def authenticate_current_user!
    unless signed_in? && current_user?
      redirect_to root_path, alert: t("flash.not_authenticated")
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
  end
end
