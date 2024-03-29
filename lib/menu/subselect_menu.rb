# This module groups the different menu classes that are used to for the
# terminal options. The class {Base} provides the basic methods that are needed.
# Child classes only need to implement the method {Base#define_menu_items} and
# {Base#determine_action}.
module Menu


  # menu class that inherits {Menu::Base} to abstract a menu which is used to
  # query a subselect on an index
  class SubselectMenu < Base
    include Listenable

    # initialization
    # @param [Array] ranking the sorted n result with the highest ranking mapped
    # as (attribute => occurrence)
    def initialize(ranking)
      @menu_description = "Overview of the top n index results:"
      @ranking = ranking
      super
    end

    # method to replace the current criteria
    # @param [Symbol] criteria the ranking criteria
    def change_index(criteria)
      @criteria = criteria
    end

    private

    # @return [Array] an array that holds arrays of size two with [value, rank]
    attr :ranking
    # @return [Symbol] criteria the ranking criteria
    attr :criteria

    # implementation to define the items of the menu
    def define_menu_items
      @ranking.each { |entry|
        text = "#{entry[0]} [#{entry[1]}]"
        add_menu_item(text)
      }
      add_menu_item("Return to previous menu.")
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      input_number = input.to_i
      case
        when (input_number == @menu_items.size) then return false
        when (input.to_i > @menu_items.size) || (input.to_i < 1)
          puts "Invalid input. Please try again."
          return false
        else
          index_menu = Menu::IndexSelectionMenu.new()
          index_menu.add_listener(:subselect_menu, self)
          index_menu.print_menu
          notify_listeners(:generate_subselect, @ranking[input.to_i - 1][0],
                                                @criteria)
      end
    end

  end

end
