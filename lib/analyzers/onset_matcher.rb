class Analyzers::OnsetMatcher
  attr_reader :correctly_detected_onsets, :missed_onsets, :false_positive_onsets, :merged_onsets, :double_onsets
  def initialize(onset_array_a, onset_array_b)
    @onset_array_a = onset_array_a
    @onset_array_b = onset_array_b
    @correctly_detected_onsets = 0 #Ocd
    @missed_onsets = 0
    @merged_onsets = 0
    @double_onsets = 0
    @false_positive_onsets = 0
  end

  # TODO: this tolerance_ms doesnt make sense for the relative values where 0 <= x <= 1
  def run(tolerance_ms=50)
    t = tolerance_ms.to_f/1000
    r = @onset_array_a.map do |a|
      @onset_array_b.select{|b| b > (a-t) && b < a+t }
    end.map{|s| s.count}
    r.each do |x|
      @correctly_detected_onsets += 1 if x>=1
      @missed_onsets += 1 if x==0
      @double_onsets += 1 if x>1
    end

    @false_positive_onsets = @onset_array_b.map do |a|
      @onset_array_a.select{|b| b > (a-t) && b < a+t }
    end.map{|s| s.count}.select{|s| s==0}.count
    self
  end

  def precision
    @correctly_detected_onsets / (@correctly_detected_onsets + @false_positive_onsets).to_f
  end

  def recall
    @correctly_detected_onsets / (@correctly_detected_onsets + @missed_onsets).to_f
  end

  def f_measure
    2 * precision * recall / (precision + recall).to_f
  end

  def false_positive_rate
    100 * (@false_positive_onsets / (@correctly_detected_onsets+@false_positive_onsets).to_f)
  end

  def stats
    {precision: precision, recall: recall, f_measure: f_measure}
  end

end
