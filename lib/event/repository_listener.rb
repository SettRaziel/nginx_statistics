# @Author: Benjamin Held
# @Date:   2016-07-15 15:43:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-09-10 16:41:28

require_relative '../output/string'
require_relative '../statistic/statistic.rb'
require_relative '../menu/menu'

# helper class which create a connection between event handling and the
# {DataRepository}
class RepositoryListener

  # initialization
  # @param [DataRepository] data_repository the repository that the Listener
  #    should notify
  def initialize(data_repository)
    @data_repository = data_repository
    @observed_objects = Array.new()
  end

  # method to register an instance of this class at a {Listenable}
  # @param [Object] listenable an object of a class that uses the {Listenable}
  #   module
  def listen_to(listenable)
    listenable.add_listener(:repo_listener, self)
  end

  # method to notify the repository to create a new index for the given key
  # @param [Symbol] key the new index key
  def change_index(key)
    @data_repository.create_index(key)
  end

  # method to generate the ranking over the index and print its results
  def generate_and_print_index
    ranking = Statistic.generate_ranking_for_index(@data_repository.index, 10)
    puts 'Output as: number of occurence | entry content'.yellow
    ranking.each { |entry|
      print "%5s ".red % [entry[1]]
      puts "times: #{(entry[0]).to_s.magenta} "
    }
  end

  # method to generate the required ranking and present a menu to select
  # the key for the subselect on that index
  def initialize_subselect
    ranking = Statistic.generate_ranking_for_index(@data_repository.index, 10)
    subselect_menu = Menu::SubselectMenu.new(ranking)
    subselect_menu.add_listener(:repo_listener, self)
    subselect_menu.print_menu
  end

  # method to retrieve all entries with the value at the given criteria from
  # the index and print the top n ranking of the result
  # @param [Object] value the search value
  # @param [Symbol] criteria the ranking criteria
  def generate_and_print_subselect(value, criteria)
    entries = @data_repository.get_entries_from_index_to(value)
    ranking = Statistic.generate_ranking_for(entries, 10, criteria)
    puts 'Output as: number of occurence | entry content'.yellow
    ranking.each { |entry|
      print "%5s ".red % [entry[1]]
      puts "times: #{(entry[0]).to_s.magenta} "
    }
  end

  private

  # @return [DataRepository] the represented repository
  attr :data_repository

end
