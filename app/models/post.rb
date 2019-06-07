class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
  has_and_belongs_to_many :hashtags

  after_create do
    post = Post.find_by(id: self.id)
    # 半角もしくは全角の"#"に続けて、#やスペース以外の文字が１文字以上続く文字列をハッシュタグとする
    hashtags  = self.caption.scan(/[#＃][^#＃\p{blank}]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.slice(0)) #先頭の"#"は除いて保存
      post.hashtags << tag
    end
  end

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
end
