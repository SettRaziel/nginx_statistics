# @Author: Benjamin Held
# @Date:   2016-07-14 17:40:05
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-08-01 15:35:52

module Menu

  require_relative '../event/listenable'

  class MainMenu < Base
    include Listenable

    def initialize
      super
      @menu_description = 'Main menu. Select operation:'
    end

    def define_menu_items
      add_menu_item('Create different index.', 1)
      add_menu_item('Print current index.', 2)
      add_menu_item('Quit.', 3)
    end

    def determine_action(input)
      case (input.to_i)
        when 1
          index_menu = Menu::IndexMenu.new()
          index_menu.add_listener(:repo_listener, listeners[:repo_listener])
          index_menu.print_menu
        when 2
          notify_listeners(:generate_and_print_index)
        when 3
          exit(0)
      end
    end

  end

end
