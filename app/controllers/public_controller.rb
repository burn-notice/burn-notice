class PublicController < ApplicationController
  respond_to :html

  def open
    @notice = Notice.find_by_token!(params[:token])
    flash.now[:alert] = "The Burn-Notice is not available any longer!" unless @notice.open?
    @opening = @notice.openings.create do |it|
      it.ip = request.ip
      it.meta = {
        user_agent: request.user_agent,
        referer: request.referer,
      }
    end
  end

  def read
    @notice = Notice.find_by_token!(params[:token])

    @opening = @notice.openings.find(params[:opening_id])
    if @notice.valid_secret?(params[:answer])
      if @notice.open?
        @opening.update! authorization: :authorized
        @data = @notice.read_data(params[:answer])
        @notice.apply_policy(authorized: true)
      else
        redirect_to(root_path, alert: 'The Burn-Notice is no longer available!')
      end
    else
      @opening.update! authorization: :unauthorized
      @notice.apply_policy(authorized: false)
      if @notice.disabled?
        redirect_to(root_path, alert: 'The notice has been disabled due to too many invalid attempts!')
      else
        redirect_to(open_path(@notice), alert: 'The shared secret was invalid!')
      end
    end
  end
end
