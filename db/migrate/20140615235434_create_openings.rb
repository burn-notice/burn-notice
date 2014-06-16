class CreateOpenings < ActiveRecord::Migration
  def change
    create_table :openings do |t|
      t.boolean :authorized
      t.string :ip
      t.text :info
      t.references :notice

      t.timestamps
    end
  end
end
