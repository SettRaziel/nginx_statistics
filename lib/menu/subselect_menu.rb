# @Author: Benjamin Held
# @Date:   2016-07-13 10:12:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-09-11 18:40:37

module Menu

  class SubselectMenu < Base
    include Listenable

    def initialize(ranking)
      @menu_description = 'Overview of the top n index results:'
      @ranking = ranking
      super
    end

    def change_index(criteria)
      @criteria = criteria
    end

    private

    # @return [Array] an array that holds arrays of size two with [value, rank]
    attr :ranking
    attr :criteria

    def define_menu_items
      @ranking.each { |entry|
        text = "#{entry[0]} [#{entry[1]}]"
        add_menu_item(text)
      }
      add_menu_item("Return to previous menu.")
    end

    def determine_action(input)
      input_number = input.to_i
      case
        when (input_number == @menu_items.size) then return false
        when (input.to_i > @menu_items.size) || (input.to_i < 1)
          puts "Invalid input. Please try again."
          return false
        else
          index_menu = Menu::IndexMenu.new()
          index_menu.add_listener(:subselect_menu, self)
          index_menu.print_menu
          notify_listeners(:generate_and_print_subselect,
                           @ranking[input.to_i - 1][0], @criteria)
      end
    end

  end

end
