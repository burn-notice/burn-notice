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

  def signup
    @auth = session[:auth_data]
    check_existing_user(@auth['info']['email'])
    @user = User.new(nickname: @auth['info']['nickname'], email: @auth['info']['email'])
    @user.authorizations.build provider: @auth['provider'], uid: @auth['uid']
  end

  def complete
    @user = User.new(params.require(:user).permit!)
    if @user.save
      session.delete(:auth_data)
      mail = UserMailer.signup(@user)
      MailerJob.new.async.deliver(mail)
      sign_in(@user)
      redirect_to session.delete(:auth_path), notice: "Hi #{@user.nickname}, welcome to Burn-Notice!"
    else
      check_existing_user(params[:user][:email])
      render :signup
    end
  end

  private

  def check_existing_user(email)
    if existing_user = User.find_by_email(email)
      providers = existing_user.authorizations.map(&:provider)
      flash.now[:alert] = "An existing user was found for #{email}, please sign in through #{providers.to_sentence}!"
    end
  end
end
