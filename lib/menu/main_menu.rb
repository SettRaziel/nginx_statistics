module Menu

  require_relative '../event/listenable'
  require_relative '../output/string'

  # menu class that inherits {Menu::Base} to abstract the main menu
  class MainMenu < Base
    include Listenable

    # initialization
    def initialize
      super
      @menu_description = 'Main menu. Select operation:'
    end

    private

    # implementation to define the items of the menu
    def define_menu_items
      add_menu_item('Create or change index.', 1)
      add_menu_item('Print an index.', 2)
      add_menu_item('Generate bar chart.', 3)
      add_menu_item('Quit.', 4)
    end

    # method to specify the actions to a given input
    # @param [String] input the user input
    def determine_action(input)
      case (input.to_i)
        when 1 then prepare_menu(Menu::IndexOverviewMenu.new())
        when 2 then prepare_menu(Menu::IndexOutputMenu.new())
        when 3 then prepare_menu(Menu::DiagramMenu.new())
        when 4
          puts "Shutting down. Goodbye ...".yellow
          exit(0)
      end
    end

    # method to register the listener to a given menu and print its items
    # @param [Menu::Base] menu the generated menu
    def prepare_menu(menu)
      menu.add_listener(:repo_listener, listeners[:repo_listener])
      menu.print_menu
    end

  end

end
