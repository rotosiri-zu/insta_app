require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:photo_path) { Rails.root.join("app", "assets", "images", "icon.png") }

  it "is valid with a user, post, and photo" do
    user = FactoryBot.create(:user)
    post = user.posts.create
    post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))
    expect(post).to be_valid
  end
end
