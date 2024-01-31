class Recipe < ApplicationRecord
  #   has_many : details
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
end
