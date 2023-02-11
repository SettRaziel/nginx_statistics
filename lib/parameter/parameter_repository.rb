# This module holds classes that read and store the usable script arguments
module Parameter

  # Parameter repository to store the valid parameters of the script.
  # {#initialize} gets the provided parameters and fills a hash which
  # grants access to the provided parameters and their arguments
  class ParameterRepository < RubyUtils::Parameter::BaseParameterRepository
  
    # initialization
    # @param [Array] arguments Array of input parameters
    def initialize(arguments)
      super(arguments)
      has_set_mode?
    end

    private

    # method to read further argument and process it depending on its content
    # @param [String] arg the given argument
    def process_argument(arg)
      case arg
        when *@mapping[:http_request] then set_mode(:http_request)
        when *@mapping[:source] then set_mode(:source)
        when *@mapping[:http_status] then set_mode(:http_status)
        when *@mapping[:timestamp] then set_mode(:timestamp)          
        when *@mapping[:index] then create_argument_entry(:index)
      else
        raise_invalid_parameter(arg)
      end
      nil
    end

    # method to define the input string values that will match a given paramter symbol
    def define_mapping
      @mapping[:index] = ["-i", "--index"]
      @mapping[:http_request] = ["--request"]
      @mapping[:source] = ["--source"]
      @mapping[:http_status] = ["--status"]
      @mapping[:timestamp] = ["-t", "--timestamp"]
    end

    # method to check and set the requested working mode
    # @param [Symbol] symbol the symbol that represents the selected mode
    # @raise [ArgumentError] if the mode has already beed set
    def set_mode(symbol)
      if (!@parameters[:mode])
        @parameters[:mode] = symbol
      else
        raise ArgumentError, "Error: Mode has already been set.".red
      end
      nil
    end

    # method to check if a mode has been specified in the input parameters
    def has_set_mode?
      if (!@parameters[:mode] &&
          !(@parameters[:help] || @parameters[:version]))
          puts "Warning: No mode has been specified. Using --status.".yellow
      end
      nil
    end

  end

end
