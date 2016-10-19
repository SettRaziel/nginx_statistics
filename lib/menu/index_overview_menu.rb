# @Author: Benjamin Held
# @Date:   2016-10-19 22:36:51
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-10-19 23:26:04

module Menu

  require_relative '../event/listenable'
  require_relative '../output/string'

  # menu class that inherits {Menu::Base} to create a menu for the provided
  # index creation options
  class IndexOverviewMenu < Base
    include Listenable

    # initialization
    def initialize
      super
      @menu_description = 'Index operation menu. Select operation:'
    end

    # implementation to define the items of the menu
    def define_menu_items
      add_menu_item('Create different index.', 1)
      add_menu_item('Subselect index.', 2)
      add_menu_item('Return to previous menu.', 3)
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      case (input.to_i)
        when 1
          index_menu = Menu::IndexSelectionMenu.new()
          index_menu.add_listener(:repo_listener, listeners[:repo_listener])
          index_menu.print_menu
        when 2
          notify_listeners(:initialize_subselect)
        when 3 then return
      end
    end

  end

end
