class RemoveBodyAndTitleFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :title
    remove_column :articles, :body
  end
end
