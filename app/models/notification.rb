class Notification < ApplicationRecord
  belongs_to :to_user, class_name: "User"
  belongs_to :from_user, class_name: "User"
  belongs_to :direct_message, optional: true
  belongs_to :like, optional: true
  belongs_to :comment, optional: true
  belongs_to :relationship, optional: true
end
