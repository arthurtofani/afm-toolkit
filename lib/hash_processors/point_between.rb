class HashProcessors::PointBetween < HashProcessor
  def run
    result = []
    @event_table.each do |ev_a| # arr of Event
      @event_table.nearest_events_of(ev_a).each do |ev_b|
        @event_table.nearest_events_of(ev_b).each do |ev_c|
          result << [
            ev_a.to_v,
            ev_b.to_v,
            ev_c.to_v,
            ev_b.distance_from(ev_a)/ev_c.distance_from(ev_a)
          ]
        end
      end
    end
    result
  end
end
