class FingerprintAlgorithm
  def initialize(audio)
    @audio = audio
    read_events
  end

  def generate; raise MustImplementError; end

  def create_onsets(label, method_name, params)
    onset_method(method_name).create(label, params)
  end

  def onset_method(method_name)
    # returns a wrapper to the given onset
  end

  def read_events
    @event_table = EventTable.new
    onsets_files.each do |file|
      method_name = file["method_name"]
      label = file["label"]
      file["onsets"].each do |onset|
        @event_table.add_event(onset["timestamp"], label, onset["value"])
      end
    end
  end

  def hashes
    hashes = hash_processor.run
    hashes = hashes.map{ |h| transform_hash(h) }
  end

  def onsets_files
    [] # objects from yaml files
  end

end
