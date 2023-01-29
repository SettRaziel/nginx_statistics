require 'ruby_utils/string'
require_relative '../statistic/statistic.rb'
require_relative '../menu/menu'
require_relative '../output/index_diagram/ranking_diagram'

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
  def generate_and_output_index
    ranking = Statistic.generate_ranking_for_index(@data_repository.index, 10)
    output_ranking(ranking)
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
  def generate_subselect(value, criteria)
    entries = @data_repository.get_entries_from_index_to(value)
    @subselect_ranking = Statistic.generate_ranking_for(entries, 10, criteria)
    puts "Generated subindex.".yellow
  end

  # method to print the calculated ranking in the terminal
  # @param [Hash] ranking the sorted result with the highest ranking mapped as
  #   (attribute => occurrence)
  def output_ranking(ranking)
    puts 'Output as: number of occurence | entry content'.yellow
    ranking.each { |entry|
      print "%5s ".red % [entry[1]]
      puts "times: #{(entry[0]).to_s.magenta} "
    }
  end

  # method to print the calculated ranking in the terminal
  def output_index_ranking
    check_subselect
    output_ranking(@subselect_ranking)
  end

  # method to generate a bar chart based on the source parameter
  # @param [Symbol] source an indicator for which data a bar chart should be
  #   generated
  # @raise [ArgumentError] if the provided source was not found
  def output_barchart(source)
    case (source)
      when :index
        ranking = Statistic.
                  generate_ranking_for_index(@data_repository.index, 10)
        RankingDiagram.new(ranking)
      when :subselect
        check_subselect
        RankingDiagram.new(@subselect_ranking)
    else
      raise ArgumentError, "Error: Unknown index type for bar chart"
    end
  end

  private

  # @return [DataRepository] the represented repository
  attr :data_repository
  # @return [Array] the sorted n result with the highest ranking mapped
    # as (attribute => occurrence) from the subselect
  attr_accessor :subselect_ranking

  # method to check if a subselect was already generated
  # @raise [ArgumentError] if no subselect has been generated
  def check_subselect
    if (@subselect_ranking == nil)
      raise ArgumentError, "Error: No subindex created".red
    end
  end

end
