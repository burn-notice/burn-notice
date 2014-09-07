class AddTokenToBetaUsers < ActiveRecord::Migration
  def change
    add_column :beta_users, :token, :string
  end
end
