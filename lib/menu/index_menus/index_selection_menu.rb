module Menu

  # menu class that inherits {Menu::Base} to abstract the menu to select a
  # given status
  class IndexSelectionMenu < Base
    include Listenable

    # initialization
    def initialize
      @menu_description = 'Index overview. Select the criteria for the index:'
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
