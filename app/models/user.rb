class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true #loses the cached value for password on reload from database
  validates :email, presence: true
  validates :email, :uniqueness => {:case_sensitive => false}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.find_or_create_from_facebook(auth_hash)
      self.where(email: auth_hash["info"]["email"]).first_or_create do |u|
        u.username = auth_hash.info.name
        u.password = SecureRandom.hex
      end
  end

end
