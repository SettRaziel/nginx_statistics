# @Author: Benjamin Held
# @Date:   2016-07-15 15:43:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-07-30 13:10:42

require_relative '../output/string'

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
    puts 'number; entry'
    ranking.each { |entry|
            puts ("%5s times: %s ") % [entry[1], entry[0]]
    }
  end

  private

  # @return [DataRepository] the represented repository
  attr :data_repository

end
