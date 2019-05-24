require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:photo_path){ Rails.root.join("app", "assets", "images","icon.png") }
  before do
    user = FactoryBot.create(:user)
    @post = user.posts.create
  end
  it "is valid with a user, post, and photo" do
    photo = @post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))
    expect(photo).to be_valid
  end
  it "is invalid photo without image" do
    photo = @post.photos.create(image: nil)
    expect(photo).not_to be_valid
  end
end
