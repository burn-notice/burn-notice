class ApplicationController < ActionController::Base
  include UserHandling
  include ActiveAdminHandling

  force_ssl if Rails.env.production?
  protect_from_forgery with: :exception
end
