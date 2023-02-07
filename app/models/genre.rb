class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :genrename, uniqueness: true, presence: true
end
