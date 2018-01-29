# @Author: Benjamin Held
# @Date:   2016-06-07 09:15:43
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-01-29 14:54:09

require_relative '../lib/data/data_repository'
require_relative '../lib/parameter/parameter_repository'
require_relative '../lib/output/help_output'
require_relative '../lib/string/string'
require_relative '../lib/event/repository_listener'
require_relative '../lib/menu/menu'

# call to print version number and author
def print_version
  puts 'nginx_statisic version 0.3.0'.yellow
  puts 'Created by Benjamin Held (May 2016)'.yellow
end

#-------------------------------------------------------------------------------
# Nginx Statistics Script
# Version 0.3.0
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

    # necessary to clear the script parameter, which has already been
    # processed by the parameter_repository
    ARGF.argv.clear

    rl = RepositoryListener.new(dr)

    menu = Menu::MainMenu.new()
    rl.listen_to(menu)
    while (true)
      menu.print_menu
    end
  end
rescue StandardError => e
  puts e.message
  puts 'For help type: ruby <script> --help'.green
  exit(0)
end
