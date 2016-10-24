class NoticesController < ApplicationController
  before_action :authenticate!
  around_action :user_time_zone, if: :change_time_zone?

  def index
    @filter_status = [:open, :disabled, :closed]
    @order_sent = 'ASC'

    @notices = current_user.notices.includes(:policy, :openings).page(params[:page])
    if filter = params[:filter]
      @notices = @notices.where(status: filter[:status]) if filter[:status]
    end
    if order = params[:order]
      if order[:sent]
        @notices = @notices.reorder(created_at: order[:sent])
        @order_sent = 'DESC' if order[:sent] == 'ASC'
      end
    end

  end

  def show
    @notice = current_user.notices.includes(:policy, :openings).from_param(params[:id])
  end

  def new
    @notice = current_user.notices.build
    @notice.policy = Policy.from_name
  end

  def first_step
    if request.get?
      @step = :first
      @notice = current_user.notices.build
    else
      @notice = current_user.notices.build(notice_params)
      @notice.policy = Policy.from_name
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

    share_via_email(@notice)
  end

  def share
    @notice = current_user.notices.from_param(params[:id])

    share_via_email(@notice)
  end

  def create
    @notice = current_user.notices.build(notice_params)
    @notice.policy = Policy.from_name(policy_params.symbolize_keys)
    if @notice.save
      redirect_to share_notice_path(@notice), notice: t('notices.created')
    else
      render :new, flush: true
    end
  end

  def enable
    @notice = current_user.notices.from_param(params[:id])
    @notice.update! status: :open

    redirect_to notices_path, notice: t('notices.enabled')
  end

  def disable
    @notice = current_user.notices.from_param(params[:id])
    @notice.update! status: :disabled

    redirect_to notices_path, notice: t('notices.disabled')
  end

  def destroy
    @notice = current_user.notices.from_param(params[:id])
    @notice.cremate!

    redirect_to notices_path, notice: t('notices.destroyed')
  end

  def bulk
    action = params[:bulk_action] || 'destroy'
    notices = Notice.active.find(params[:selected])
    case action
    when 'destroy'
      flash[:notice] = t('notices.bulk_destroyed')
      notices.each { |notice| notice.cremate! }
    end

    redirect_to notices_path
  end

  private

  def share_via_email(notice)
    if params[:notice]
      if recepients = params.require(:notice)[:share_recipients].presence
        recepients = recepients.strip.split(/[\s,;]+/)
        recepients.each do |recepient|
          mail = UserMailer.notify(current_user, recepient, notice)
          MailerJob.perform_async(mail, I18n.locale)
        end

        redirect_to :back, notice: t('notices.sent_via_email', recepients: recepients.to_sentence)
      else
        notice.errors.add(:share_recipients, :blank)
      end
    end
  end

  def notice_params
    params.require(:notice).permit(:question, :answer, :content)
  end

  def policy_params
    params.require(:notice).require(:policy_attributes).permit(:name, :duration, :amount)
  end
end
