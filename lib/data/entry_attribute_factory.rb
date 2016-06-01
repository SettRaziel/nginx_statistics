# @Author: Benjamin Held
# @Date:   2016-05-24 12:52:28
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-06-01 16:43:55

module Entry

    # Factory class to retrieve the required attribute to the given symbol
    class EntryAttributeFactory

      # method to retrieve the requested attribute for the given {Entry::Entry}
      # object
      # @param [Symbol] symbol the symbol representing the requested attribute
      # @param [Entry] entry the {Entry::Entry} whose attribute should be
      #    retrieved
      # @return [Object] the requested attribute
      def self.get_attribute_to(symbol, entry)
        case symbol
        when :source then entry.source
        when :remote_user then entry.remote_user
        when :timestamp then entry.timestamp
        when :http_request then entry.http_request
        when :http_status then entry.http_status
        when :element_size then entry.element_size
        when :http_referer then entry.http_referer
        when :user_agent then entry.user_agent
        else
          raise ArgumentError,
                "Error in EntryAttributeFactory: provided symbol #{symbol}" \
                " does not exist."
        end
      end

    end

end
