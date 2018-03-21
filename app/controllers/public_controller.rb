class PublicController < ApplicationController
  respond_to :html
  before_action :get_notice

  def open
    @opening = @notice.openings.create do |it|
      it.ip = request.ip
      it.meta = {
        user_agent: request.user_agent,
        referer: request.referer,
      }
    end
  end

  def read
    @opening = @notice.openings.find(params[:opening_id])
    if @notice.valid_secret?(params[:answer])
      @opening.update! authorization: :authorized
      @data = @notice.read_data(params[:answer])
      @notice.apply_policy(authorized: true)
    else
      @opening.update! authorization: :unauthorized
      @notice.apply_policy(authorized: false)
      if @notice.disabled?
        redirect_to(root_path, alert: t('public.too_many_attempts'))
      else
        redirect_to(open_path(@notice), alert: t('public.invalid_answer'))
      end
    end
  end

  def read_public
    @data = @notice.read_data(params[:answer])
    render :read
  end

  private

  def get_notice
    @notice = Notice.find_by_token!(params[:token])

    redirect_to(root_path, alert: t('public.no_longer_available')) unless @notice.unread?
  end
end
