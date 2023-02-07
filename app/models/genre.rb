class Genre < ApplicationRecord
  validates :genrename, uniqueness: true, presence: true
end
