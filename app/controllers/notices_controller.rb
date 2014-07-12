class NoticesController < ApplicationController
  before_action :authenticate!

  def index
    @notices = current_user.notices.page(params[:page])
  end

  def new
    @notice = current_user.notices.build
  end

  def create
    @notice = current_user.notices.build(create_notice_params)
    if @notice.save
      redirect_to notices_path, notice: 'You created a new notice'
    else
      render :new
    end
  end

  private

  def create_notice_params
    params.require(:notice).permit(:password, :content, :policy)
  end
end
