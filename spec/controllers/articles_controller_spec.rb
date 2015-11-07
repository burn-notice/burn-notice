require 'spec_helper'

describe ArticlesController do
  before do
    @article = Fabricate(:article)
  end

  context "articles#index" do
    it "loads all active articles and article-facets" do
      get :index

      expect(response).to be_success
      expect(assigns[:articles].size).to be(1)
      expect(assigns[:facets].size).to be(2)
    end

    it "loads a feed in rss" do
      get :index, format: :rss

      expect(response).to be_success
      expect(response.content_type).to eql(Mime::RSS.to_s)
    end
  end

  context "articles#show" do
    it "loads article and article-facets" do
      get :show, id: @article

      expect(response).to be_success
      expect(assigns[:article]).to eql(@article)
      expect(assigns[:facets].size).to be(2)
    end
  end
end
