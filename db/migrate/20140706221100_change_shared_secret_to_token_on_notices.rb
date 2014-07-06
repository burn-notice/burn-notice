class ChangeSharedSecretToTokenOnNotices < ActiveRecord::Migration
  def change
    rename_column :notices, :shared_secret, :token
  end
end
