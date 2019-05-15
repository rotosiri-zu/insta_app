require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  given(:photo_path){ Rails.root.join("app", "assets", "images","icon.png") }
  given(:user){ FactoryBot.create(:user) }
  scenario "create new post" do
    sign_in user
    expect {
      visit new_post_path
      fill_in "コメントを書く", with: "コメント"
      attach_file photo_path
      click_button "投稿する"
      expect(page).to have_content "投稿が保存されました"
    }.to change(user.posts, :count).by(1)
  end

  scenario "delete post", js: true do
    sign_in user
    post = user.posts.create
    photo = post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))

    expect {
      visit user_path(user)
      page.first(".card-img-top").click
      sleep 1
      page.first(".delete-post-icon").click
    }.to change(user.reload.posts, :count).by(-1)
  end
end
