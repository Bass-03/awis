module Aws
  require "csv"
  class Utils
    # Reads given CSV, gets domain from last column
    # @param path [String] path to the csv
    # @return Array
    def self.readCSV(path)
      data = CSV.read(path)
      return data
    end
    # Reads given CSV, gets domain from last column
    # @param path [String] path to the csv
    # @param data [Array] Array of arrays containing information for the csv file
    def self.writeCSV(path,data)
      CSV.open("myfile.csv", "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
    end
  end
end
