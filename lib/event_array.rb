require 'audio_event'

class EventArray < Array
  def initialize
    @sorted = true
  end

  # timestamp => the distance in miliseconds from the signal's start time
  def add_event(timestamp, label, value)
    ev = AudioEvent.new(timestamp, label, value)
    self << ev
    @sorted = false
    ev
  end

  def sort_events!
    return self if @sorted
    self.sort!{ |a, b| a.timestamp<=>b.timestamp }
    @sorted = true
    self
  end

  def nearest_events_of(event, min_distance=0, max_distance=1000, max_elements=9999) #  distances in milliseconds
    self.select do |ev|
      ev != event &&
      ev.timestamp >= event.timestamp+min_distance &&
        ev.timestamp <= event.timestamp+max_distance
    end
  end

  def to_s
    "#{count} events"
  end
end
