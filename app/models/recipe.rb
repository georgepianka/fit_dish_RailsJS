class Recipe < ApplicationRecord
  belongs_to :recipiable, polymorphic: true
  has_many :ingredients
  has_many :substitutions
  validates :ingredients, presence: true
end
