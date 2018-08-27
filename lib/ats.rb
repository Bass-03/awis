module Aws
  require "aws/version"
  require "aws_request"
  require "json"
  class Ats
    # The TopSites action provides lists of web sites ordered by Alexa Traffic Rank.
    # A global list is available, as well as lists for individual countries.
    # @param country_code [String] Valid country code. A global list of top sites is returned by default.
    # @param start [String] Number of result at which to start. Used for paging through results.
    # @param count [String] Number of results (maximum) per page to return. Maximum is '100'.
    # @return Hash
    def top_sites(country_code = false,start = '1',count = '100')
      query = {
        "Action"           => "TopSites",
        "ResponseGroup"    => "Country",
        "Count"            => count,
        "Start"            => start
      }
      query["CountryCode"] = country_code if country_code
      info = Aws::Request.new("ats",query)
      return info.hash
    end
    # List of country codes
    # @return Hash
    def list_countries
      query = {
        "Action"           => "TopSites",
        "ResponseGroup"    => "ListCountries",
      }
      info = Aws::Request.new("ats",query)
      return info.hash
    end
  end
end
