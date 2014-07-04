class ApplicationController < ActionController::Base
  include UserHandling
  include ActiveAdminHandling

  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user

  if Rails.env.production?
    force_ssl

    rescue_from ActiveRecord::RecordNotFound,     with: :_404
    rescue_from ActionView::MissingTemplate,      with: :_404
    rescue_from ActionController::UnknownFormat,  with: :_404
  end

  private

  def _404(exception)
    Rails.logger.warn exception
    Rails.logger.warn "head 404 with params #{params}"

    raise ActionController::RoutingError.new('Not Found')
  end
end
