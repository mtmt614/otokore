class Post < ApplicationRecord
  
  belongs_to :user
  belongs_to :genre
  has_many :likes, dependent: :destroy
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
end
