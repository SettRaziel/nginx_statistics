# @Author: Benjamin Held
# @Date:   2016-04-08 17:05:43
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-06-29 15:32:26

require_relative 'file_reader'
require_relative 'entry'
require_relative '../output/string'

# This class serves as a data repository storing the read data and handling the
# meta information
class DataRepository
  # @return Hash returns specific mapping on the given key (values => Array)
  attr_reader :index
  # @return Array an array containing all entries
  attr_reader :repository

  # initialization
  # @param [String] filename the filepath
  # @param [Symbol] key the attribute for the index
  def initialize(filename, key = nil)
    @index = Hash.new()
    @repository = Array.new()
    begin
      create_entries(read_file(filename))
      if (key != nil)
        create_mapping(key)
      else
        create_mapping(:http_status)
      end
    rescue Exception => e
      puts "Error: #{e.message}".red
    end
  end

  # method to get the number of entries for the given key
  # @param [String] key the requested key
  # @return [Integer] the number of entries
  def get_count_to_key(key)
    if (!@index.empty?)
      @index[key].size
    else
      puts 'Error: index is empty. No index has been created!'.red
    end
  end

  # method to retrieve the number of entries for every key
  # @return [Hash] a mapping of (key => number of entries)
  def get_keys_and_their_count
    result = Hash.new()
    @index.each_key { |key|
      result[key] = @index[key].size
    }
    return result
  end

  private

  # creates {Entry}s of the parsed data and stores it in the repository
  # @param [Array] data the read data
  def create_entries(data)
    data.each { |line|
      @repository << Entry::Entry.new(line) if (!line.empty?)
    }
  end

  # creates an index, mapping all {Entry}s
  # @param [Symbol] key the index attribute
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
