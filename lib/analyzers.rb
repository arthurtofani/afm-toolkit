module Analyzers
  def find_best_onset_methods(source_audio, degradation_methods)
#     degradation_methods.each do |degradation_method|
#       # skip generation if already generated
#       degr_audio = generate_degradated_version(source_audio, degradation_method)
#       # dtw??
#       test_onset_method("hfc_subband1", source_audio, degr_audio)
#       test_onset_method("hfc_subband2", source_audio, degr_audio)
#     end
  end

  def compare_results(query, original, algorithm_name)
    #source_hashes = Echoprint.new(source_audio).hashes
    #degr_hashes = Echoprint.new(degr).hashes
    #count_statistics(source_hashes, degr_hashes)
  end
end
