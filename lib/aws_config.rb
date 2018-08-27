module Aws
  class AWS_config
    # Read the key and secret from the aws credentials file
    # file is normally on ~/.aws
    # ENV["aws"] overrides the location
    def read_keys
      if ENV["AWS"]
        path = ENV["AWS"]
      else
        path = "#{ENV["HOME"]}/.aws"
      end
      keys = {}
      file_text = File.read(path + "/credentials")
      file_text.each_line do |line|
        # skip line if is a section header
        next if line.include? "[]"
        # if line includes '=' then it is a variable
        if line.include? "="
          line = line.partition("=")
          keys[line[0].strip.to_sym] = line[2].strip
        end
      end
      return keys
    end
  end
end
