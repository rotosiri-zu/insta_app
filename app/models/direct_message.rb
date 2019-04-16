class DirectMessage < ApplicationRecord
  belongs_to :direct_message_space
  belongs_to :user
end
