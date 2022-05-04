class PostImage < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  validates :shop_name, presence: true
  validates :image, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def get_image(size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize: size).processed
  end
end
