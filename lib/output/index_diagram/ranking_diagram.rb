# @Author: Benjamin Held
# @Date:   2016-10-03 23:30:13
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-11-05 10:32:39

require_relative 'terminal_size'

# logic class to draw a simple bar chart for the given ranking
class RankingDiagram

  # initialization
  # @param [Array] ranking an array storing the values and the numbers of
  #   occurences in nested arrays
  def initialize(ranking)
    @entry_size = 20
    retrieve_terminal_width
    accumulate_numbers(ranking)

    ranking.each { |entry|
      print_hash_pair(entry)
    }

    print_x_axis
  end

  private
  # @return [Number] the width available for the bars
  attr_accessor :width
  # @return [Number] the overall number of considered entries
  attr_accessor :count
  # @return [Number] the maximal length of the value characters that are printed
  attr_accessor :entry_size

  # method to get the size information of the used terminal
  def retrieve_terminal_width
    ts = TerminalSize::TerminalSize.new()
    @width = ts.columns - @entry_size - 3
  end

  # method to print the value, the bar and the percentage of the occurence based
  # on the overall number of considered entries
  def print_hash_pair(entry)
    print "%#{@entry_size}s |" % [entry[0].to_s[0...@entry_size]]
    ratio = entry[1] * 1.0 / @count

    # print dynamic bar for value
    (ratio * @width).round.times {
      print "="
    }
    puts " (#{(ratio * 100).round(2)}%)"
  end

  # method to print the x data axis
  def print_x_axis
    print "%#{@entry_size}s |" % ["portion in %"]

    axis_numbers = initialize_axis_numbers
    counter = 0.1;
    1.upto(@width) do |i|
      if ( i % (counter * @width).round == 0)
        print "|"
        axis_numbers = axis_numbers[0...-1].concat((counter * 100).round.to_s)
        counter += 0.1
      else
        print "-"
        axis_numbers.concat(" ")
      end
    end

    puts "\n#{axis_numbers}"
  end

  # helper method to calculate the number of all considered entries
  # @param [Array] ranking an array storing the values and the numbers of
  #   occurences in nested arrays
  def accumulate_numbers(ranking)
    @count = 0
    ranking.each { |entry|
      @count += entry[1]
    }
  end

  # helper method to initialize the string printing the number values of
  # the x axis
  # @return [String] the starting characters of the x axis number string
  def initialize_axis_numbers
    axis = ""
    (entry_size + 1).times { axis.concat(" ")}
    axis.concat("0")
  end

end
