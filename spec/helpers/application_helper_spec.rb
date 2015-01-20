require 'spec_helper'

describe ApplicationHelper do
  context "markdown" do
    it "renders markdown" do
      expect(helper.markdown("moin _klaus_")).to eql("<p>moin <em>klaus</em></p>\n")
    end

    it "handles linebreaks" do
      expect(helper.markdown("moin\nklaus")).to eql("<p>moin<br>\nklaus</p>\n")
    end
  end
end
