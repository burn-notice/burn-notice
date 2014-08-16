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
    if @notice.valid_secret?(params[:answer])
      @opening.authorized = true
      @opening.save
      @data = @notice.read_data(params[:answer])
    else
      @opening.authorized = false
      @opening.save
      redirect_to(open_path(@notice), alert: 'The shared secret was invalid!')
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
