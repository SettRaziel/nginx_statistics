# @Author: Benjamin Held
# @Date:   2016-07-13 10:12:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-08-27 17:24:56

module Menu

  class SubselectMenu < Base
    include Listenable

    def initialize(ranking)
      @menu_description = 'Overview of the top n index results:'
      @ranking = ranking
      super
    end

    private

    # @return [Array] an array that holds arrays of size two with [value, rank]
    attr :ranking

    def define_menu_items
      @ranking.each { |entry|
        text = "#{entry[0]} [#{entry[1]}]"
        add_menu_item(text)
      }
      add_menu_item("Return to previous menu.")
    end

    def determine_action(input)
      case (input.to_i)
        when @menu_items.size then return false
        else
          notify_listeners(:generate_and_print_subselect,
                           @ranking[input.to_i][0])
      end
    end

  end

end
