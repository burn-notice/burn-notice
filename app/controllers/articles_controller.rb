class ArticlesController < ApplicationController
  layout 'blog'

  def index
    @articles = Article.active
  end
end
