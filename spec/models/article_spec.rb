require 'spec_helper'

describe Article do
  let(:article) { Fabricate.build(:article) }

  context "validation" do
    it "is valid" do
      expect(article).to be_valid
    end
  end

  context "finder" do
    before do
      @article = Fabricate(:article)
    end

    it "has a friendly url" do
      article = Article.from_param(@article.to_param)
      expect(article).to eql(@article)
    end
  end
end
