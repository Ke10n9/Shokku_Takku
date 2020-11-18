class Menu < ApplicationRecord
  belongs_to :user
  has_many :dishes, dependent: :destroy
  default_scope -> { order( updated_at: :desc ) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :date, presence: true
  validates :time, presence: true, uniqueness: { scope: [:user_id, :date], case_sensitive: true }
  # case_sensitive: true ... 大文字小文字を区別するユニーク制約。これがないとrspecでエラーになる。
  #                         明示せよと言われる？
  validate :picture_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB以上の画像はアップロードできません。")
      end
    end
end
