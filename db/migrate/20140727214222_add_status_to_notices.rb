class AddStatusToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :status, :integer, default: 0
  end
end
