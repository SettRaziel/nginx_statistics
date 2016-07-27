# @Author: Benjamin Held
# @Date:   2016-07-15 15:43:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-07-27 16:18:19

require_relative '../output/string'

class RepositoryListener

  def initialize(data_repository)
    @data_repository = data_repository
    @observed_objects = Array.new()
  end

  def listen_to(listenable)
    listenable.add_listener(:repo_listener, self)
  end

  def change_index(key)
    @data_repository.create_index(key)
  end

  def generate_and_print_index
    ranking = Statistic.generate_ranking_for_index(@data_repository.index, 10)
    puts 'number; entry'
    ranking.each { |entry|
            puts ("%5s times: %s ") % [entry[1], entry[0]]
    }
  end

  private

  attr :data_repository

end
