RSpec.describe Aws::Request do
  before(:all) do
    query = {
      "Action"           => "UrlInfo",
      "ResponseGroup"    => "Rank",
      "Url"              => "eyeo.com"
    }
    @info = Aws::Request.new("awis",query)
  end
  it "calls the awis endpoint" do
    expect(@info.response).to be_kind_of Net::HTTPOK
  end

  it "gets an XML from Awis" do
    expect(@info.xml).to be_kind_of REXML::Document
  end

  it "gets an hash from Awis" do
    expect(@info.hash).to be_kind_of Hash
  end
end
