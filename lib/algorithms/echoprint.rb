class Echoprint < FingerprintAlgorithm
  # cria arquivos com marcações, para leitura posterior
  # um para cada definição
  # ignora caso o arquivo já esteja criado, a menos que 'force'
  def generate(force=false)
    create_onsets("hfc_band_1", "hfc_subband", { hop_size: 512, subband: 1 })
    create_onsets("hfc_band_2", "hfc_subband", { hop_size: 512, subband: 2 })
    create_onsets("hfc_band_3", "hfc_subband", { hop_size: 512, subband: 3 })
    create_onsets("hfc_band_4", "hfc_subband", { hop_size: 512, subband: 4 })
    create_onsets("hfc_band_5", "hfc_subband", { hop_size: 512, subband: 5 })
    create_onsets("hfc_band_6", "hfc_subband", { hop_size: 512, subband: 6 })
    create_onsets("hfc_band_7", "hfc_subband", { hop_size: 512, subband: 7 })
    create_onsets("hfc_band_8", "hfc_subband", { hop_size: 512, subband: 8 })
  end

  def hash_processor
    @hash_processor ||= HashProcessors::Wang03.new(@event_table)
  end

  def transform_hash(hash_value)
    murmur_hash32(hash_value)
  end

  def murmur_hash32(hash_value)
    hash_value
  end

end
