class AddGoogleAuthConnectionToNotice < ActiveRecord::Migration
  def change
    add_reference :notices, :google_auth_connection, index: true
  end
end
