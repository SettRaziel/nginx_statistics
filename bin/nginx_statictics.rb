# @Author: Benjamin Held
# @Date:   2016-06-07 09:15:43
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-06-20 18:03:44

require_relative '../lib/data/data_repository'
require_relative '../lib/parameter/parameter_repository'
require_relative '../lib/statistic/statistic.rb'
require_relative '../lib/output/help_output'
require_relative '../lib/output/string'

# call to print version number and author
def print_version
  puts 'nginx_statisic version 0.1.0'.yellow
  puts 'Created by Benjamin Held (May 2016)'.yellow
end

#-------------------------------------------------------------------------------
# Nginx Statistics Script
# Version 0.1.0
# created by Benjamin Held, May 2016

if (ARGV.length < 1)
  puts 'Invalid number of arguments: usage ruby <script> ' \
       '<criteria> <filename>'.red
  puts 'For help type: ruby <script> --help'.green
  exit(0)
end

begin
  parameters = Parameter::ParameterRepository.new(ARGV)

  if (parameters.parameters[:help])
    HelpOutput.print_help_for(parameters.parameters[:help])
  elsif (parameters.parameters[:version])
    print_version
  else
    dr = DataRepository.new(parameters.parameters[:file],
                            parameters.parameters[:mode])

    ranking = Statistic.generate_ranking_for_index(dr.index, 10)

    ranking.each { |entry|
      puts "Found: #{entry[0]} #{entry[1]} times"
    }
  end
rescue Exception => e
  puts e.message
  puts 'For help type: ruby <script> --help'.green
  exit(0)
end
