class PostHashtag < ApplicationRecord
  belongs_to :post
  belongs_to :hashtag
  validates  :post_id, presence: true
  validates  :Hashtag_id,   presence: true
end
