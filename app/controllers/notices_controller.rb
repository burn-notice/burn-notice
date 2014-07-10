class NoticesController < ApplicationController
  before_action :authenticate!

  def index
    @notices = current_user.notices
  end
end
