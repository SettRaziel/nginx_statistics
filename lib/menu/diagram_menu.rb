# @Author: Benjamin Held
# @Date:   2016-10-19 23:30:19
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-10-19 23:32:41

module Menu

  require_relative '../event/listenable'
  require_relative '../output/string'

  # menu class that inherits {Menu::Base} to create a menu for the provided
  # index creation options
  class DiagramMenu < Base
    include Listenable

    # initialization
    def initialize
      super
      @menu_description = 'Bar diagram menu. Select operation:'
    end

    # implementation to define the items of the menu
    def define_menu_items
      add_menu_item('Bar diagram for main index.', 1)
      add_menu_item('Bar diagram for subselect index.', 2)
      add_menu_item('Return to previous menu.', 3)
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      case (input.to_i)
        when 1
          # print normal index diagram
        when 2
          # check for subselect; print subselect diagram
        when 3 then return
      end
    end

  end

end
