class UseLanguageForArticles < ActiveRecord::Migration
  def change
    add_column :articles, :content, :json
    add_column :articles, :headline, :json

    Article.all.each do |article|
      article.update! content: {en: article[:body], en: article[:body]}, headline: {en: article[:title], en: article[:title]}
    end
  end
end
