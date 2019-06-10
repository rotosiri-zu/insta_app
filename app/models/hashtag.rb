class Hashtag < ApplicationRecord
  has_many :hashtag_posts, dependent: :destroy
  has_many :posts, through: :hashtag_posts
  validates :hashname, presence: true, length: { maximum: 50 }

  def posted_users
    posts.map { |post| post.user }.uniq
  end
end
