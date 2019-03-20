class User < ApplicationRecord
  has_secure_password

  has_many :recipes
  has_many :dishes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :substitutions
  has_many :recipe_lists, through: :dishes, source: :recipe
  has_many :favorite_recipes, through: :likes, source: :recipe

  validates :username, presence: true
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  # has_secure_password ensures can't be blank on create. User loses the cached value for password on reload from database.
  # allowing nil password_field on update so saving without entering anything will NOT overwrite password.
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
