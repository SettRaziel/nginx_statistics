require "ruby_utils/string"
require_relative "../lib/data/data_repository"
require_relative "../lib/parameter"
require_relative "../lib/output/help_output"
require_relative "../lib/event/repository_listener"
require_relative "../lib/menu/menu"

# call to print version number and author
def print_version
  puts "nginx_statisic version 0.4.0".yellow
  puts "Created by Benjamin Held (May 2016)".yellow
end

#-------------------------------------------------------------------------------
# Nginx Statistics Script
# Version 0.4.0
# created by Benjamin Held, May 2016

if (ARGV.length < 1)
  puts "Invalid number of arguments: usage ruby <script> " \
       "<criteria> <filename>".red
  puts "For help type: ruby <script> --help".green
  exit(0)
end

begin
  parameter_handler = Parameter::ParameterHandler.new(ARGV)

  if (parameter_handler.repository.parameters[:help])
    HelpOutput.print_help_for(parameter_handler.repository.parameters[:help])
  elsif (parameter_handler.repository.parameters[:version])
    print_version
  else
    dr = DataRepository.new(parameter_handler.repository.parameters[:file],
                            parameter_handler.repository.parameters[:mode])
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
  puts "For help type: ruby <script> --help".green
  exit(0)
end
