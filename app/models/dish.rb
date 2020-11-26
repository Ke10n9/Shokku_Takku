class Dish < ApplicationRecord
  belongs_to :menu
  validates :name, presence: true, length: { maximum: 30 }
  validates :category, presence: true

  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name])
  end

  # nameが存在する場合、nameをlike検索する
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
end
