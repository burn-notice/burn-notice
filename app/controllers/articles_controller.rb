class ArticlesController < ApplicationController
  layout 'blog'

  def index
    @articles = search_scope
    tags = Article.active.pluck(:tags)
    @tags_count = tags.flatten.each_with_object(Hash.new(0)) { |tag, counts| counts[tag] += 1 }
    ranges = {
      'this year'   => 1.year.ago,
      'this month'  => 1.month.ago,
      'this week'   => 1.week.ago,
    }
    @dates_count = ranges.each_with_object(Hash.new(0)) { |(name, start), counts| counts[name] += Article.where(published_at: (start..Time.now)).count }
  end

  private

  def search_scope
    scope = Article.active.page(params[:page])
    scope = scope.where('? = ANY (tags)', params[:tag]) if params[:tag]
    scope
  end
end
