
module Awis
  class AWS_config
    # Read the key and secret from the aws credentials file
    # file is normally on ~/.aws
    # ENV["aws"] overrides the location
    def readFile
      if ENV["AWS"]
        path = ENV["AWS"]
      else
        path = "#{ENV["HOME"]}/.aws"
      end
      puts File.read(path + "credentials")
    end
  end
end
