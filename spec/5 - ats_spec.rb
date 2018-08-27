RSpec.describe Aws::Ats do
  it "gets data from ATS List Countries succesfully" do
    aws = Aws::Ats.new
    data = aws.list_countries
    expect(data.dig(:TopSitesResponse,:Response,:TopSitesResult,:Alexa,:TopSites)).to_not be nil
  end
  it "gets data from ATS Contry succesfully" do
    aws = Aws::Ats.new
    data = aws.top_sites("MX")
    expect(data.dig(:TopSitesResponse,:Response,:TopSitesResult,:Alexa,:TopSites)).to_not be nil
  end
end
