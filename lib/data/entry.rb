# @Author: Benjamin Held
# @Date:   2016-04-09 22:01:56
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-05-22 15:40:07

require 'time'

# Entity class to represent a standard logging entry of an nginx logfile
class Entry
  # @return [String] the source address stored as a string
  attr_reader :source
  # @return [String] the information of the remote user
  attr_reader :remote_user
  # @return [Time] the timestamp of the representing entry
  attr_reader :timestamp
  # @return [String] the http request
  attr_reader :http_request
  # @return [Integer] the http status
  attr_reader :http_status
  # @return [Integer] the size of the result in bytes
  attr_reader :element_size
  # @return [String] the site from where the request was issued
  attr_reader :http_referer
  # @return [String] the used browser program or user agent
  attr_reader :user_agent

  # initialization
  # @param [String] input_string the string representation of the log entry
  def initialize(input_string)
    @source = input_string[0]
    @remote_user = input_string[2]
    @timestamp = parse_timestamp(input_string[3], input_string[4])
    @http_request = input_string[5]
    @http_status = parse_integer(input_string[6])
    @element_size = parse_integer(input_string[7])
    @http_referer = input_string[8]
    @user_agent = input_string[9]
  end

  # method to get a formatted string
  # @return [String] the formatted entry string
  def to_string
    "#{@source} #{@remote_user} #{@timestamp} #{@http_request} "\
    "#{@http_status} #{@element_size} byte #{@http_referer}\n#{@user_agent}"
  end

  private

  # helper method to parse the timestamp from the time informations
  # @param [String] time_string the date information coded in a string
  # @param [String] time_zone the used timezone coded in a string
  # @return [Time] the created time object
  def parse_timestamp(time_string, time_zone)
    time_string.slice!(0)
    time_zone.chomp(']')
    Time.strptime(time_string.concat(time_zone), "%d/%b/%Y:%T%z")
  end

  # helper method to parse the given string to an integer
  # @param [String] int_string the given string
  # @return [Integer] the parsed string
  def parse_integer(int_string)
    Integer(int_string)
  end

end
