class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost.content.max_length}
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :by_followed, lambda do |user_id|
    where("user_id IN (SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id)
      OR user_id = :user_id", user_id: user_id).order created_at: :desc
  end

  private

  def picture_size
    if picture.size > Settings.micropost.picture.size.megabytes
      errors.add :picture, t("model.mocropost.error")
    end
  end
end
