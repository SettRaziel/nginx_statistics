# @Author: Benjamin Held
# @Date:   2016-10-03 23:30:13
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-10-16 12:52:26

require_relative 'terminal_size'

class RankingDiagram

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
  attr_accessor :width
  attr_accessor :count
  attr_accessor :entry_size

  def retrieve_terminal_width
    ts = TerminalSize::TerminalSize.new()
    @width = ts.columns - @entry_size - 3
  end

  def print_hash_pair(entry)
    print "%#{@entry_size}s |" % [entry[0].to_s[0...@entry_size]]
    ratio = entry[1] * 1.0 / @count

    # print dynamic bar for value
    (ratio * @width).round.times {
      print "="
    }
    puts " (#{(ratio * 100).round(2)}%)"
  end

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

  def accumulate_numbers(ranking)
    @count = 0
    ranking.each { |entry|
      @count += entry[1]
    }
  end

  def initialize_axis_numbers
    axis = ""
    (entry_size + 1).times { axis.concat(" ")}
    axis.concat("0")
  end

end
