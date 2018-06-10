class NoveltyFunctions::Hfc < NoveltyFunction
  def initialize(audio, label)
    super(audio, 'hfc', label)
  end

  def process(params)
    values = Aubio.new(@audio).run('hfc', params)
    @audio.events[@label] = create_output(values)
  end
end
