class Menu < ApplicationRecord
  belongs_to :user
  has_many :dishes, dependent: :destroy
  default_scope -> { order(updated_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :date, presence: true
  validates :time, presence: true, uniqueness: { scope: [:user_id, :date] }
end
