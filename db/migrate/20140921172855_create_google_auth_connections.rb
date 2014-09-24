class CreateGoogleAuthConnections < ActiveRecord::Migration
  def change
    create_table :google_auth_connections do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :status, default: 0
      t.string :token
      t.string :email

      t.timestamps
    end
  end
end
