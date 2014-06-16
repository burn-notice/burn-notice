class ApplicationController < ActionController::Base
  include UserHandling
  include ActiveAdminHandling

  force_ssl
  protect_from_forgery with: :exception
end
