require "rails_helper"

RSpec.feature "Likes", type: :feature do
  given(:photo_path) { Rails.root.join("app", "assets", "images", "icon.png") }
  given(:user) { FactoryBot.create(:user) }
  given(:other) { FactoryBot.create(:user) }

  scenario "user make like other's post", js: true do
    sign_in user
    post = other.posts.create
    post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))
    visit user_path(other)
    page.first(".card-img-top").click
    sleep 1
    page.first(".love").click
    sleep 1
    expect(page).to have_css(".loved")
    expect(user.reload.likes.size).to eq 1
    expect(post.reload.likes.size).to eq 1
    expect(page).to have_content "いいね！1件"
    visit likes_user_path(user)
    expect(page).to have_css("img")
    visit liked_user_path(other)
    expect(page).to have_css("img")
  end

  scenario "delete like", js: true do
    sign_in user
    post = other.posts.create
    post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))
    post.likes.create(user: user)
    visit user_path(other)
    page.first(".card-img-top").click
    sleep 1
    page.first(".loved").click
    sleep 1
    expect(page).to have_css(".love")
    expect(user.reload.likes.size).to eq 0
    expect(post.reload.likes.size).to eq 0
    visit likes_user_path(user)
    expect(page).not_to have_css(".card-wrap")
    visit liked_user_path(other)
    expect(page).not_to have_css(".card-wrap")
  end
end
