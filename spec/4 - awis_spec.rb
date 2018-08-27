RSpec.describe Aws::Awis do
  it "gets data from awis urlinfo succesfully" do
    aws = Aws::Awis.new
    site = "eyeo.com"
    data = aws.url_info(site,"Rank")
    expect(data.dig(:UrlInfoResponse,:Response,:UrlInfoResult,:Alexa,:TrafficData,:DataUrl)).to include site
  end
  it "gets data from awis traffic history succesfully" do
    aws = Aws::Awis.new
    site = "eyeo.com"
    data = aws.traffic_history(site)
    expect(data.dig(:TrafficHistoryResponse,:Response,:TrafficHistoryResult,:Alexa,:TrafficHistory,:Site)).to include site
  end
  it "gets data from awis urlinfo with a start date succesfully" do
    aws = Aws::Awis.new
    site = "eyeo.com"
    data = aws.traffic_history(site,(Date.today - 400).to_s)
    expect(data.dig(:TrafficHistoryResponse,:Response,:TrafficHistoryResult,:Alexa,:TrafficHistory,:Site)).to include site
  end
end
