class NoticesController < ApplicationController
  before_action :authenticate!

  def index
    @notices = current_user.notices
  end

  def new
    @notice = Notice.new
    @notice.openings.build
  end

  def create
    notice = Notice.new params.require(:notice).permit!
    notice.save
    raise ''
  end
end
