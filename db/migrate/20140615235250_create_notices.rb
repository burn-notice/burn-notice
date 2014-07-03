class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.json :data
      t.string :shared_secret
      t.references :user

      t.timestamps
    end
  end
end
