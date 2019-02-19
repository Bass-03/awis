module Aws
  require "csv"
  #require "fileutils"
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
      CSV.open(path, "w") do |csv|
        data.each do |row|
          csv << row
        end
      end
    end
    # Agregates all files in folder recursively.
    # @param path [String] path to the csv
    # @return Array
    def self.agregate(path,data = [])
      Dir.foreach(path) do |file|
        next if file == '.' or file == '..'
        if Dir.exists? path + "/" + file
          new_path = path + "/" + file
          self.agregate(new_path,data)
          next
        end
        traffic_data = File.read(path + "/" + file)
        hash_data = JSON.parse(traffic_data,:symbolize_names => true)
        data << hash_data
      end
      return data
    end
  end

end
