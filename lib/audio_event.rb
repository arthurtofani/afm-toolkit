class AudioEvent
  attr_reader :timestamp, :label
  def initialize(timestamp, label, value)
    @timestamp, @label, @value = timestamp, label, value
  end

  def distance_from(other_event)
    (other_event.timestamp - timestamp).abs
  end

  def to_v
    "#{@label}:#{@value}"
  end
end
