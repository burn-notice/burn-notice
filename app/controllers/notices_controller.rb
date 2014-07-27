class NoticesController < ApplicationController
  before_action :authenticate!

  def index
    @notices = current_user.notices.page(params[:page])
  end

  def new
    @notice = current_user.notices.build
  end

  def first_step
    if request.get?
      @step = :first
      @notice = current_user.notices.build
    else
      @notice = current_user.notices.build(create_notice_params)
      if @notice.save
        redirect_to second_step_notice_path(@notice)
      end
    end
  end

  def second_step
    @notice = current_user.notices.from_param(params[:id])
    if request.get?
      @step = :second
    else
      if @notice.update_attributes(update_notice_params)
        redirect_to third_step_notice_path(@notice)
      end
    end
  end

  def third_step
    @step = :third
    @notice = current_user.notices.from_param(params[:id])
  end

  def create
    @notice = current_user.notices.build(create_notice_params)
    if @notice.save
      redirect_to notices_path, notice: 'You created a new notice!'
    else
      render :new
    end
  end

  def destroy
    @notice = current_user.notices.from_param(params[:id])
    @notice.destroy!
    redirect_to notices_path, notice: 'The notice is deleted!'
  end

  private

  def create_notice_params
    params.require(:notice).permit(:question, :answer, :content, policy_attributes: [:name])
  end

  def update_notice_params
    params.require(:notice).permit(:question, :answer, :content, policy_attributes: [:name])
  end
end
