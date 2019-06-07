class Hashtag < ApplicationRecord
  has_and_belongs_to_many :posts
  validates :hashname, presence: true, length: {maximum:50}
end
