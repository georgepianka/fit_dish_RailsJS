class Recipe < ApplicationRecord
  belongs_to :recipiable, polymorphic: true
end
