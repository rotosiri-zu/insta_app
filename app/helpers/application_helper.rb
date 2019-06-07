module ApplicationHelper
  def avatar_url user
    return user.profile_photo.url(:medium) unless user.profile_photo.blank?
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
  end

  def current_user?(user)
    user == current_user
  end

  def full_title(page_title = '')
    base_title = "Insta_App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
