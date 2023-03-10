class Post < ApplicationRecord
  
  validates :title, presence: true
  validates :artist, presence: true
  
  belongs_to :user
  belongs_to :genre, optional: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_one_attached :image
  
  def get_image
    if image.attached?
      image
    else
      'onpu.jpg'
    end
  end
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
end
