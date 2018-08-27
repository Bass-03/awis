RSpec.describe Aws::AWS_signing do
  it "gets signature for AWIS" do
    file = Aws::AWS_config.new
    keys = file.read_keys
    query = {
      "Action"           => "UrlInfo",
      "ResponseGroup"    => "Rank",
      "Url"              => "eyeo.com"
    }
    aws = Aws::AWS_signing.new("awis",keys[:aws_access_key_id],keys[:aws_secret_access_key],query)
    expect(aws.authorization_header).to include :uri,:timestamp,:auth_header
  end
end
