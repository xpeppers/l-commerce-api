module UserTokenGenerator

  def self.generate
    SecureRandom.uuid.gsub(/\-/, '')
  end

end
