class OnsetArray < Array
  attr_accessor :audio_length, :label
  def initialize(label, values, audio_length)
    @label = label
    @audio_length = audio_length
    values.each{|v| self << v}
  end

  def relative_values
    l = @audio_length.to_f
    self.map{|s| s*1000 / l}
  end

end
