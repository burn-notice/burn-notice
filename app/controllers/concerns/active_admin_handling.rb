module ActiveAdminHandling
  extend ActiveSupport::Concern

  included do
    helper_method :destroy_admin_user_session_path
  end

  protected

  def authenticate_admin_user!
    if current_user.present?
      current_user.admin?
    end
  end

  def current_admin_user
    current_user
  end

  def destroy_admin_user_session_path
    logout_path
  end
end
