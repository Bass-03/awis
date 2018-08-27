
module Aws
  require "aws/version"
  require "aws_request"
  require "json"
  require "date"

  class Awis
    # The UrlInfo action provides information about a website.
    # Posible reponse Groups:
    # Categories
    # Up to 3 categories the site belongs to
    #
    # Rank
    # The Alexa three month average traffic rank
    #
    # RankByCountry
    # Percentage of viewers, page views, and traffic rank broken out by country
    #
    # UsageStats
    # Usage statistics such as reach and page views
    #
    # AdultContent
    # Whether the site is likely to contain adult content ('yes' or 'no')
    #
    # Speed
    # Median load time and percent of known sites that are slower
    #
    # Language
    # Content language code and character-encoding (note that this may not match the language or character encoding of any
    # given page on the website because the languange and character set returned are those of the majority of pages)
    #
    # OwnedDomains
    # Other domains owned by the same owner as this site
    #
    # LinksInCount
    # A count of links pointing in to this site
    #
    # SiteData
    # Title, description, and date the site was created
    # @param site [String]  Any valid URL.
    # @param response_group [String] Any valid response group.
    # @return Hash
    def url_info(site, response_group = "Categories,Rank,RankByCountry,UsageStats,AdultContent,Speed,Language,OwnedDomains,LinksInCount,SiteData")
      query = {
        "Action"           => "UrlInfo",
        "ResponseGroup"    => response_group,
        "Url"              => site
      }
      info = Aws::Request.new("awis",query)
      return info.hash
    end
    # The TrafficHistory action returns the daily Alexa Traffic Rank, Reach per Million Users,
    # and Unique Page Views per Million Users for each day going back 4 years.
    # Sites with a rank in excess of 1,000,000 are not included.
    # @param site [String] Any valid URL.
    # @param start [String] Start date for results. A date within the last 4 years in format YYYYMMDD.
    # @param range [String] Number of days to return. Maximum value is '31'.
    # @return Hash
    def traffic_history(site, start = false, range = "31")
      query = {
        "Action"           => "TrafficHistory",
        "ResponseGroup"    => "History",
        "Url"              => site,
      }
      query["Start"] = Date.parse(start).strftime("%Y%m%d") if start
      query["Range"] = range
      info = Aws::Request.new("awis",query)
      return info.hash
    end
  end
end
