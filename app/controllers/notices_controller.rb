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
      @notice = current_user.notices.build(notice_params)
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
      @notice.policy = Policy.from_name(policy_params.symbolize_keys)
      if @notice.save
        redirect_to third_step_notice_path(@notice)
      end
    end
  end

  def third_step
    @step = :third
    @notice = current_user.notices.from_param(params[:id])
  end

  def create
    @notice = current_user.notices.build(notice_params)
    @notice.policy = Policy.from_name(policy_params.symbolize_keys)
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

  def notice_params
    params.require(:notice).permit(:question, :answer, :content)
  end

  def policy_params
    params.require(:notice).require(:policy).permit(:name, :interval)
  end
end
