# @Author: Benjamin Held
# @Date:   2015-05-30 21:00:25
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-05-09 12:51:05

require 'csv'

# Simple file reader using the csv library to read a csv file
# requires csv
# @raise [IOError] if the csv-gem throws an exception
class FileReader
  # @return an array containing all lines of the separeted by the delimiter
  attr_reader :data

  # initialization
  # @param [String] filename filepath of the file which should be read
  # @param [String] delimiter the column delimiter that is need to read the file
  # @raise [IOError] if an error occurs while the file is read
  def initialize(filename, delimiter)
    begin
      @data = CSV.read(filename, { :col_sep => delimiter })
    rescue Exception => e
      raise IOError, e.message.concat('.')
    end
  end

end
