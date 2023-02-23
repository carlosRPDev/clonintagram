class Post < ApplicationRecord
  has_one_attached :image

  validates :image, presence: true

  belongs_to :user
  has_many :comments
end
