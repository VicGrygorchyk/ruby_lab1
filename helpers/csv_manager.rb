# encoding utf-8
=begin
This script opens a json file and convers it to csv file
=end
require "csv"

module CSVManager

    def CSVManager.save_to_csv(path_to_csv, array)
        # open a csv file and write an array of hash elements to it
        # use the hash keys as a csv headers
        
        CSV.open(path_to_csv, "w+", headers: array[0].keys, write_headers: true) do |csv_file|
            array.each do |element|
                csv_file << element.values
            end
        end
    end

end
