# @Author: Benjamin Held
# @Date:   2016-04-19 21:31:13
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-06-06 15:16:33

# module to generate the required statisitc result for the requested attribute
module Statistic

  require_relative '../data/entry_attribute_factory'

  # method to generate a top n ranking for the given criteria
  # @param [Array] data an array holding the selected entries
  # @param [Integer] rank the requested number of results
  # @param [Symbol] criteria the ranking criteria
  # @return [Hash] the sorted n result with the highest ranking mapped as
  #   {result => occurrence}
  def self.generate_ranking_for(data, rank, criteria)
    mapping = Hash.new()
    data.each { |entry|
      attribute = Entry::EntryAttributeFactory.get_attribute_to(criteria, entry)
      if (mapping[attribute] == nil)
        mapping[attribute] = 1
      else
        mapping[attribute] += 1
      end
    }

    ranking = mapping.sort_by {|k, v| [v, k] }.reverse
    return ranking.first(rank)
  end

end
