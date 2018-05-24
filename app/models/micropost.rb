class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost.content.max_length}
  validate  :picture_size

  scope :order_by_created_at, ->{order(created_at: :asc)}

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size >Settings.micropost.picture.size.megabytes
      errors.add :picture, t("model.mocropost.error")
    end
  end
end
