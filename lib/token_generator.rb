module TokenGenerator

  def self.generate
    SecureRandom.uuid.gsub(/\-/, '')
  end

end
