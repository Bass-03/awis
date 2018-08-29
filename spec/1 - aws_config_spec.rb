RSpec.describe Aws::AWS_config do
  it "reads keys from file" do
    file = Aws::AWS_config.new
    expect(file.read_keys).to include(:aws_access_key_id, :aws_secret_access_key)
  end
  it "gets aws config folder from ENV['AWS']" do
    ENV["AWS"] = "#{ENV["HOME"]}/.aws"
    file = Aws::AWS_config.new
    expect(file.read_keys).to include(:aws_access_key_id, :aws_secret_access_key)
    ENV.delete("AWS") #clean up ENV["AWS"]
  end
  it "fails if file is not found" do
    ENV["AWS"] = "wrong_location"
    file = Aws::AWS_config.new
    expect {file.read_keys}.to raise_error Errno::ENOENT
    ENV.delete("AWS") #clean up ENV["AWS"]
  end
end
