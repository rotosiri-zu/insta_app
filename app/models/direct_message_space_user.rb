class DirectMessageSpaceUser < ApplicationRecord
  belongs_to :user
  belongs_to :direct_message_space
end
