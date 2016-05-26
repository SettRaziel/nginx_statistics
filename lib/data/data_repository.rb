# @Author: Benjamin Held
# @Date:   2016-04-08 17:05:43
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-05-26 11:42:37

require_relative 'file_reader'
require_relative 'entry'

# This class serves as a data repository storing the read data and handling the
# meta information
class DataRepository
  # @return Hash mapping {Key} -> {Array}
  attr_reader :index
  # @return Array an array containing all entries
  attr_reader :repository

  # initialization
  # @param [String] filename filepath
  def initialize(filename, key = nil)
    @index = Hash.new()
    @repository = Array.new()
    begin
      create_entries(read_file(filename))
      create_mapping(key) if (key != nil)
    rescue Exception => e
      puts "Error: #{e.message}"
    end
  end

  # method to get the number of entries for the given key
  # @param [String] the requested key
  # @return [Integer] the number of entries
  def get_count_to_key(key)
    if (!@index.empty?)
      @index[key].size
    else
      puts 'Error: index is empty. No index has been created!'
    end
  end

  # method to retrieve the number of entries for all keys
  # @return [Hash] a mapping of key => number of entries
  def get_keys_and_their_count
    result = Hash.new()
    @index.each_key { |key|
      result[key] = @index[key].size
    }
    return result
  end

  private

  # reads the file and creates data of its content with default meta
  # information
  # @param [String] filename filepath
  # @return [MetaData] the meta data object for this data
  def add_data_with_default_key(data)
    create_entries(data, :timestamp)
  end

  # creates {DataSet}s of the parsed data and stores it into a {DataSeries}
  # @param [Array] data the read data
  # @return [DataSeries] the data series created by the data input
  def create_entries(data)
    data.each { |line|
      @repository << Entry::Entry.new(line) if (!line.empty?)
    }
  end

  # creates {DataSet}s of the parsed data and stores it into a {DataSeries}
  # @param [Array] data the read data
  # @return [DataSeries] the data series created by the data input
  def create_mapping(key)
    @repository.each { |entry|
        mapped_key = map_key_to_attribute(key, entry)
        @index[mapped_key] = Array.new() if (!@index[mapped_key])
        @index[mapped_key] << entry
    }
  end

  # method to determine the mapping to the given attribute of the {Entry}
  # @param [Symbol] key the mapping key
  # @param [Entry] entry the actual considered entry
  def map_key_to_attribute(key, entry)
    case key
      when :source then entry.source
      when :http_status then entry.http_status
      when :http_request then entry.http_request
    else
      entry.timestamp
    end
  end

  # calls the FileReader to get the content of the file
  # @param [String] filename filepath
  # @return [Array] the data of the file as strings
  def read_file(filename)
    FileReader.new(filename, ' ').data
  end

end
