class AudioHash
  attr_reader :timestamp, :hash
  def initialize(timestamp, hsh)
    @timestamp, @hash = timestamp, hsh
  end
end
