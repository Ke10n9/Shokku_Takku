class Dish < ApplicationRecord
  belongs_to :menu
  validates :name, presence: true, length: { maximum: 30 }
end
