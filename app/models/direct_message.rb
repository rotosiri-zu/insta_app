class DirectMessage < ApplicationRecord
  belongs_to :direct_message_space
  belongs_to :user
  has_one :notification
  accepts_nested_attributes_for :notification
end
