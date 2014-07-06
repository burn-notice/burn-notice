class AddMetaToOpenings < ActiveRecord::Migration
  def change
    add_column :openings, :meta, :json
  end
end
