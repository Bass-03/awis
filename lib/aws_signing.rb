module Aws
  require 'uri'
  require 'openssl'
  require 'cgi'

  class AWS_signing
    #Signing AWS Requests By Using Signature Version 4
    #http://docs.aws.amazon.com/general/latest/gr/sigv4_signing.html
    def initialize(service_name,key,secret,query)
      @service_name = service_name
      @key = key
      @secret = secret
      @query = query
    end

    def authorization_header
      service_host = "#{@service_name}.amazonaws.com"
      service_endpoint = "#{@service_name}.us-west-1.amazonaws.com"
      # Service name correction if it is ats
      @service_name = "AlexaTopSites" if @service_name == "ats"
      #service_port = 443
      service_uri = "/api"
      service_region = "us-west-1"

      def getSignatureKey(key, dateStamp, regionName, serviceName)
        kDate    = OpenSSL::HMAC.digest('sha256', "AWS4" + key, dateStamp)
        kRegion  = OpenSSL::HMAC.digest('sha256', kDate, regionName)
        kService = OpenSSL::HMAC.digest('sha256', kRegion, serviceName)
        kSigning = OpenSSL::HMAC.digest('sha256', kService, "aws4_request")
        kSigning
      end

      # escape str to RFC 3986
      def escapeRFC3986(str)
        return URI.escape(str,/[^A-Za-z0-9\-_.~]/)
      end

      #task 1
      timestamp = ( Time::now ).utc.strftime("%Y%m%dT%H%M%SZ")
      datestamp = ( Time::now ).utc.strftime("%Y%m%d")

      headers = {
        "host"        => service_endpoint,
        "x-amz-date"  => timestamp
      }

      query_str = @query.sort.map{|k,v| k + "=" + escapeRFC3986(v.to_s())}.join('&')
      headers_str = headers.sort.map{|k,v| k + ":" + v}.join("\n") + "\n"
      headers_lst = headers.sort.map{|k,v| k}.join(";")
      payload_hash = Digest::SHA256.hexdigest ""
      canonical_request = "GET" + "\n" + service_uri + "\n" + query_str + "\n" + headers_str + "\n" + headers_lst + "\n" + payload_hash

      #task 2
      algorithm = "AWS4-HMAC-SHA256"
      credential_scope = datestamp + "/" + service_region + "/" + @service_name + "/" + "aws4_request"
      string_to_sign = algorithm + "\n" +  timestamp + "\n" +  credential_scope + "\n" + (Digest::SHA256.hexdigest canonical_request)

      #task 3
      signing_key = getSignatureKey(@secret, datestamp, service_region, @service_name)
      #task 4
      signature=OpenSSL::HMAC.hexdigest('sha256', signing_key, string_to_sign)
      authorization_header = algorithm + " " + "Credential=" + @key + "/" + credential_scope + ", " +  "SignedHeaders=" + headers_lst + ", " + "Signature=" + signature;


      url = "https://" + service_host + service_uri + "?" + query_str
      uri = URI(url)
      return {uri: uri,
              timestamp: timestamp,
              auth_header: authorization_header}

    end
  end
end
