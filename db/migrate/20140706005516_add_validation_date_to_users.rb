class AddValidationDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :validation_date, :timestamp
  end
end
