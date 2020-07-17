class Menu < ApplicationRecord
  belongs_to :user
  has_many :dishes, dependent: :destroy
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :date, presence: true
  validates :time, presence: true
end
