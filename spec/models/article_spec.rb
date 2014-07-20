require 'spec_helper'

describe Article do
  let(:article) { Fabricate.build(:article) }

  context "validation" do
    it "is valid" do
      expect(article).to be_valid
    end
  end
end
