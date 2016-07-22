# @Author: Benjamin Held
# @Date:   2016-07-14 18:05:20
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-07-22 08:51:57

module Listenable

    def listeners
      @listeners ||= Hash.new()
    end

    def add_listener(identification, listener)
      listeners[identification] = listener
    end

    def remove_listener(listener)
      listeners.delete(listener)
    end

    def notify_listeners(event_name, *args)
      listeners.each { |listener|
          if listener.respond_to?(event_name)
            listener.__send__(event_name, *args)
          end
      }
    end

end
