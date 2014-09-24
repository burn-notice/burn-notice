class GoogleAuthConnectionsController < ApplicationController
  before_action :authenticate!

  def create
    email = params[:google_auth_connection][:email]
    @connection = current_user.sender_connections.build(email: email)

    if recipient = User.find_by_email(email)
      @connection.recipient = recipient
    end

    @current_user.save!

    redirect_to user_path(current_user), notice: "An invitation was created for #{@connection.email}"
  end

  def connect
    @connection = current_user.pending_connections.find(params[:id])
    @connection.update! recipient: current_user

    redirect_to user_path(current_user), notice: "You accepted to invitation from #{@connection.sender.nickname}"
  end

  def update
    @connection = current_user.sender_connections.find(params[:id])
    @connection.update! status: params[:status]

    redirect_to user_path(current_user), notice: "Your Google-Authenticator connection was updated."
  end
end
