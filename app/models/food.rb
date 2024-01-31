class Food < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }
  validates :price, presence: true
  validates :measurement_unit, presence: true
  validates :quantity, presence: true
end
