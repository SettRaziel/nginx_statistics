# @Author: Benjamin Held
# @Date:   2016-07-15 16:06:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-09-18 17:32:42

module Menu

  # menu class that inherits {Menu::Base} to abstract the menu to select a
  # given status
  class IndexMenu < Base
    include Listenable

    # initialization
    def initialize
      @menu_description = 'Index menu. Select the criteria for the index:'
      super
    end

    private

    # implementation to define the items of the menu
    def define_menu_items
      add_menu_item('Http request', 1)
      add_menu_item('Http status', 2)
      add_menu_item('Sourceadress', 3)
      add_menu_item('Timestamp', 4)
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      case (input.to_i)
        when 1 then notify_listeners(:change_index, :http_request)
        when 2 then notify_listeners(:change_index, :http_status)
        when 3 then notify_listeners(:change_index, :source)
        when 4 then notify_listeners(:change_index, :timestamp)
      else
        handle_wrong_option
      end
    end

  end

end
