# @Author: Benjamin Held
# @Date:   2016-04-14 21:10:58
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-06-30 15:30:14

require_relative '../output/string'

# This module holds classes that read and store the usable script arguments
module Parameter

  class ParameterRepository
    # @return [Hash] Hash of valid parameters and their values
    attr_reader :parameters

    # initialization
    # @param [Array] arguments Array of input parameters
    def initialize(arguments)
      @parameters = Hash.new()
      unflagged_arguments = [:file]
      has_read_file = false
      arguments.each { |arg|
        has_read_file?(has_read_file)

        has_read_file =  process_argument(arg, unflagged_arguments)
      }
      has_set_mode?
    end

    private

    # method to read the given argument and process it depending on its content
    # @param [String] arg the given argument
    # @param [Array] unflagged_arguments the argument array
    # @return [boolean] if the size of the argument array is zero or not
    def process_argument(arg, unflagged_arguments)
      case arg
        when '--timestamp'        then set_mode(:timestamp)
        when '--source'           then set_mode(:source)
        when '--status'           then set_mode(:http_status)
        when '--request'          then set_mode(:http_request)
        when '-v', '--version'    then @parameters[:version] = true
        when '-h', '--help'       then check_and_set_helpvalue
        when /-[a-z]|--[a-z]+/ then raise_invalid_parameter(arg)
      else
        check_and_set_argument(unflagged_arguments.shift, arg)
      end

      return (unflagged_arguments.size == 0)
    end

    # error message in the case of an invalid argument
    # @param [String] arg invalid parameter string
    # @raise [ArgumentError] if an invalid argument is provided
    def raise_invalid_parameter(arg)
      raise ArgumentError, " Error: invalid argument: #{arg}".red
    end

    # method to check and set the requested working mode
    # @param [Symbol] symbol the symbol that represents the selected mode
    # @raise [ArgumentError] if the mode has already beed set
    def set_mode(symbol)
      if (!@parameters[:mode])
        @parameters[:mode] = symbol
      else
        raise ArgumentError, 'Error: Mode has already been set.'.red
      end
    end

    # method to check if a mode has been specified in the input parameters
    def has_set_mode?
      if (!@parameters[:mode] &&
          !(@parameters[:help] | @parameters[:version]))
          puts 'Warning: No mode has been specified. Using --status.'.yellow
      end
    end

    # checks if the filename has already been read
    # @param [boolean] read_file boolean which is true, when the filename has
    #  already been read; false, if not.
    # @raise [ArgumentError] if the file has read and other parameter are still
    #  following
    def has_read_file?(read_file)
      if (read_file)
          raise ArgumentError,
                " Error: found filepath: #{@parameters[:file]}," \
                " but there are other arguments left.".red
      end
    end

    # check if a parameter holds one or more arguments and adds the argument
    # depending on the check
    # @param [Symbol] arg_key the symbol referencing a parameter
    # @param [String] arg the argument from the input array
    # @raise [ArgumentError] if the combination of parameters is invalid
    def check_and_set_argument(arg_key, arg)
      if (arg_key != nil)
        if(@parameters[arg_key] != nil)
          @parameters[arg_key] << arg
        else
          @parameters[arg_key] = arg
        end
      else
        raise ArgumentError, ' Error: invalid combination of parameters.'.red
      end
    end

    # checks if the help parameter was entered with a parameter of if the
    # general help information is requested
    def check_and_set_helpvalue
      if(@parameters.keys.last != nil)
        # help in context to a parameter
        @parameters[:help] = @parameters.keys.last
      else
        # help without parameter => global help
        @parameters[:help] = true
      end
    end

  end

end
