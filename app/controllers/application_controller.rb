class ApplicationController < ActionController::Base
  include UserHandling
  include ActiveAdminHandling

  protect_from_forgery with: :exception
end
