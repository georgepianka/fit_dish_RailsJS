class Substitution < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true 
end
