# @Author: Benjamin Held
# @Date:   2016-07-14 17:40:05
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-09-17 17:54:37

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
      add_menu_item('Create different index.', 1)
      add_menu_item('Print current index.', 2)
      add_menu_item('Subselect index.', 3)
      add_menu_item('Quit.', 4)
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      case (input.to_i)
        when 1
          index_menu = Menu::IndexMenu.new()
          index_menu.add_listener(:repo_listener, listeners[:repo_listener])
          index_menu.print_menu
        when 2
          notify_listeners(:generate_and_print_index)
        when 3
          notify_listeners(:initialize_subselect)
        when 4
          puts "Shutting down. Goodbye ...".yellow
          exit(0)
      end
    end

  end

end
