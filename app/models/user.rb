class User < ApplicationRecord
  has_secure_password

  def self.generate_auth_token(user)
    loop do
      token = SecureRandom.hex
      break token unless user.class.exists?(auth_token: token)
    end
  end

  def self.set_auth_token(user)
    return if user.auth_token.present?
    user.auth_token = self.generate_auth_token(user)
    user.save
  end
end
