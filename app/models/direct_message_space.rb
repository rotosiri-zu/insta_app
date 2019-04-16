class DirectMessageSpace < ApplicationRecord
  has_many :direct_messages
  has_many :direct_message_space_users
end
