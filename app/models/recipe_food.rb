class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :food, uniqueness: { scope: :recipe, message: 'already exists in this recipe' }
end
