require 'spec_helper'

class Secure
  include Crypto
end

describe Crypto do
  before do
    @secure = Secure.new
  end

  it "encrypts a given string" do
    expect(@secure.encrypt("nupsi", "some-secret").keys).to have(2).elements
  end

  it "decrypts a given encrypted string" do
    data = @secure.encrypt("nupsi", "some-secret")
    expect(@secure.decrypt(data, "some-secret")).to eql("nupsi")
  end
end
