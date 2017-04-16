# @Author: Benjamin Held
# @Date:   2017-04-04 20:08:04
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-04-16 13:22:54

# menu class that inherits {Menu::Base} to create a menu for selecting time
# intervals
  class IntervalMenu < Base
    include Listenable

    # initialization
    def initialize
      super
      @menu_description = 'Interval selection menu. Specify a time interval:'
    end

    private

    # implementation to define the items of the menu
    def define_menu_items
      add_menu_item('This month.', 1)
      add_menu_item('This week.', 2)
      add_menu_item('Custom interval.', 3)
      add_menu_item('Return to previous menu.', 4)
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      case (input.to_i)
        when 1
          # create month time interval
        when 2
          # create week interval
        when 3
          # create custom interval
        when 3 then return
      end
    end

  end

end
