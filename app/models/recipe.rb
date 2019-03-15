class Recipe < ApplicationRecord
  belongs_to :recipiable, polymorphic: true
  has_many :items
  has_many :recommended_substitutions
  validates :items, presence: true
  validates :
end
