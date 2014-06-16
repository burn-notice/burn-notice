class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :name
      t.text :setting
      t.references :notice

      t.timestamps
    end
  end
end
