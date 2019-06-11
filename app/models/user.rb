class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :direct_messages, dependent: :destroy
  has_many :direct_message_space_users, dependent: :destroy
  has_many :notifications, foreign_key: "to_user_id", dependent: :destroy
  has_many :notifications, foreign_key: "from_user_id", dependent: :destroy
  has_many :foot_stamps, foreign_key: :to_user, dependent: :destroy
  has_many :foot_stamps, foreign_key: :from_user, dependent: :destroy
  has_many :users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  validates :name,      presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, length: { maximum: 50 }
  mount_uploader :profile_photo, ProfilePhotoUploader

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid:            auth.uid,
      provider:       auth.provider,
      name:           auth.info.name,
      user_name:      auth.info.name,
      email:          User.dummy_email(auth),
      remote_profile_photo_url:  auth.info.image,
      password:       Devise.friendly_token[0, 20]
    )
    user
  end

  def self.search(search)
    if search
      where(["user_name LIKE ?", "%#{search}%"])
    else
      all
    end
  end

  def feed
    Post.where("user_id IN (:following_ids)", following_ids: following_ids)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
