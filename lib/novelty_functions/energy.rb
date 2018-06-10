class NoveltyFunctions::Energy < NoveltyFunction
  def initialize(audio, label)
    super(audio, 'energy', label)
  end

  def process(params)
    values = Aubio.new(@audio).run('energy', params)
    @audio.events[@label] = create_output(values)
  end
end
