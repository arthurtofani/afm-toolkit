class NoveltyFunctions::Echoprint < NoveltyFunction
  def initialize(audio, label)
    super(audio, 'echoprint', label)
  end

  def process(params)
    subband = params[:subband] || 0
    echoprint = Echoprint.new(@audio).run
    result = echoprint.onset_subbands[subband]
    @audio.events[@label] = create_output(result)
  end
end
