module NoveltyFunctions
end

class NoveltyFunction
  def self.instantiate_strategy(method_name, audio, label)
    klass = Module.const_get("NoveltyFunctions::#{method_name.camelize}")
    klass.new(audio, label)
  end

  def process(params)
    raise MustImplementError
  end


  def initialize(audio, method_name, label)
    @audio = audio
    @method_name = method_name
    @label = label
  end

  def create_output(values)
    OnsetArray.new(@label, values, @audio.info.length)
  end
end
