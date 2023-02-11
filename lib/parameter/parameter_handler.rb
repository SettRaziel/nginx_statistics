module Parameter

  # class to seperate the storage of the parameter in a repository entity and
  # checking for valid parameter combination as part of the application logic.
  class ParameterHandler < RubyUtils::Parameter::BaseParameterHandler

    # method to initialize the correct repository that should be used 
    # in this handler
    # @param [Array] argv array of input parameters
    def initialize_repository(argv)
      @repository = Parameter::ParameterRepository.new(argv)
    end

    private

    # private method with calls of the different validations methods
    def validate_parameters
      nil
    end

    # private method to the specified parameter constraints
    def check_parameter_constraints
      # check mandatory file parameter
      check_mandatory_parameter(:file)

      # check mandatory mode parameter
      #check_mandatory_parameter(:mode)
    end

  end

end
