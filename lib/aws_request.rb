module Aws
  require "rexml/document"
  require 'net/http'
  require "aws_signing"
  require "aws_config"
  require "nori"
  class Request
    attr_reader :response
    # Makes the request to service_name
    # @param service_name [String] Service to call, could be awis or ats. Probably works with other services
    # @param query [Hash] Query to make to service_name
    def initialize(service_name,query)
      @query = query

      file = Aws::AWS_config.new
      keys = file.read_keys
      aws = Aws::AWS_signing.new(service_name,keys[:aws_access_key_id],keys[:aws_secret_access_key],@query)
      signature = aws.authorization_header
      uri = signature[:uri]
      req = Net::HTTP::Get.new(uri)
      req["Accept"] = "application/xml"
      req["Content-Type"] = "application/xml"
      req["x-amz-date"] = signature[:timestamp]
      req["Authorization"] = signature[:auth_header]

      response = Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') {|http|
        http.request(req)
      }
      @response = response
    end
    # Presents request made as XML
    # @return REXML::Document
    def xml
      xml  = REXML::Document.new( @response.body )
      return xml
    end
    # Presents request made as Hash
    # @return Hash
    def hash
      #use rexml and remove "aws:" from keys
      parser = Nori.new :parser => :rexml, :convert_tags_to => lambda { |tag| tag.gsub("aws:","").to_sym }
      hash = parser.parse(@response.body)
      return hash
    end

    # def data(xml)
    #   print "Response:\n\n"
    #   print "Links in count: "
    #   REXML::XPath.each(xml,"//aws:LinksInCount"){|el| puts el}
    #   print "Rank: "
    #   REXML::XPath.each(xml,"//aws:Rank"){|el| puts el}
    #
    #   return true
    # end
  end
end
