require 'bcrypt'

module HashGenerator

  def self.generate(string)
    BCrypt::Engine.hash_secret(string, BCRYPT_SALT)
  end

end
