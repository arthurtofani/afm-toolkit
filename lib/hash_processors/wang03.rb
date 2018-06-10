class HashProcessors::Wang03 < HashProcessor
  def run
    result = []
    @event_table.each do |event| # arr of Event
      @event_table.nearest_events_of(event).each do |ev|
        result << [event.to_v, ev.to_v, event.distance_from(ev)]
      end
    end
    result
  end
end
