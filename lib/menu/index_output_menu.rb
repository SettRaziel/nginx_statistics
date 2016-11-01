# @Author: Benjamin Held
# @Date:   2016-10-21 11:39:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-11-01 19:43:12

module Menu

  require_relative '../event/listenable'
  require_relative '../output/string'

  # menu class that inherits {Menu::Base} to create a menu for creating output
  # of a selected index
  class IndexOutputMenu < Base
    include Listenable

    # initialization
    def initialize
      super
      @menu_description = 'Index operation menu. Select operation:'
    end

    private

    # implementation to define the items of the menu
    def define_menu_items
      add_menu_item('Output main index.', 1)
      add_menu_item('Output subselect index.', 2)
      add_menu_item('Return to previous menu.', 3)
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      case (input.to_i)
        when 1
          notify_listeners(:generate_and_output_index)
        when 2
          notify_listeners(:output_ranking)
        when 3 then return
      end
    end

  end

end
