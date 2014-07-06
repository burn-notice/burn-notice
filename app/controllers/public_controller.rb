class PublicController < ApplicationController
  respond_to :html

  def open
    @notice = Notice.find_by_token!(params[:token])
  end

  def read
    @notice = Notice.find_by_token!(params[:token])
    @opening = @notice.openings.build do |it|
      it.ip = request.ip
      it.meta = {
        user_agent: request.user_agent,
        referer: request.referer,
      }
    end
    if @notice.valid_secret?(params[:password])
      @opening.authorized = true
      @opening.save
      @data = @notice.read_data(params[:password])
    else
      @opening.authorized = false
      @opening.save
      redirect_to notice_path(@notice, alert: 'The shared secret was invalid!')
    end
  end
end
