require 'spec_helper'

describe Authenticator do

  before do
    @key = '2WNBCZTCKM2BPLX3'
    @date = Time.at(1411316710)
    @authenticator = Authenticator.new(@key, @date)
  end

  it "generates qrcode urls" do
    label = 'label'
    expect(@authenticator.qrcode_image_url(label)).to eql('https://chart.googleapis.com/chart?chs=350x350&cht=qr&choe=UTF-8&chl=otpauth://totp/label?secret=2WNBCZTCKM2BPLX3')
  end

  it "checks valid keys" do
    expect(@authenticator.get_keys).to eql([37575, 217652, 171110])
    expect(@authenticator.key_valid?(217652)).to be_true
  end
end
