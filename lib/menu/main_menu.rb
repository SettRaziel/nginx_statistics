# @Author: Benjamin Held
# @Date:   2016-07-14 17:40:05
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-10-26 18:31:30

module Menu

  require_relative '../event/listenable'
  require_relative '../output/string'

  # menu class that inherits {Menu::Base} to abstract the main menu
  class MainMenu < Base
    include Listenable

    # initialization
    def initialize
      super
      @menu_description = 'Main menu. Select operation:'
    end

    # implementation to define the items of the menu
    def define_menu_items
      add_menu_item('Create or change index.', 1)
      add_menu_item('Print an index.', 2)
      add_menu_item('Quit.', 3)
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      case (input.to_i)
        when 1
          index_menu = Menu::IndexOverviewMenu.new()
          index_menu.add_listener(:repo_listener, listeners[:repo_listener])
          index_menu.print_menu
        when 2
          output_menu = Menu::IndexOutputMenu.new()
          output_menu.add_listener(:repo_listener, listeners[:repo_listener])
          output_menu.print_menu
        when 3
          puts "Shutting down. Goodbye ...".yellow
          exit(0)
      end
    end

  end

end
