# @Author: Benjamin Held
# @Date:   2016-07-14 18:05:20
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2016-11-05 19:56:39

# module to implement simple event handling and notifying
module Listenable

  # method to get get alle listener or create a new Hash, when not listener
  # is present
  # @return [Hash] the hash for storing listener to an object
  def listeners
    @listeners ||= Hash.new()
  end

  # method to add a listener which wants to be notified when a given event
  # is triggered
  # @param [Symbol] identification an identification for the listener
  # @param [Object] listener the listener object that should be added as a
  #    new listener
  def add_listener(identification, listener)
    listeners[identification] = listener
  end

  # method to remove a given listener from the list of listener objects
  def remove_listener(listener)
    listeners.delete(listener)
  end

  # method to send a notification to all listeners which respond to the
  # given event
  def notify_listeners(event_name, *args)
    listeners.each_value { |listener|
      if listener.respond_to?(event_name)
        listener.__send__(event_name, *args)
      end
    }
  end

end
