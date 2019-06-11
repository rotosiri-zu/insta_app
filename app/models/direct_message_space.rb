class DirectMessageSpace < ApplicationRecord
  has_many :direct_messages, dependent: :destroy
  has_many :direct_message_space_users, dependent: :destroy
end
