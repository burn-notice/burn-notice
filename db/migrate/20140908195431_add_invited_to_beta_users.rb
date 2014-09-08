class AddInvitedToBetaUsers < ActiveRecord::Migration
  def change
    add_column :beta_users, :invited, :timestamp
  end
end
