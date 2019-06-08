require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  given(:photo_path){ Rails.root.join("app", "assets", "images","icon.png") }
  given(:user){ FactoryBot.create(:user) }
  given(:other){ FactoryBot.create(:user) }

  scenario "user make comment other's post", js:true do
    sign_in user
    post = other.posts.create
    photo = post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))
    visit user_path(other)
    page.first(".card-img-top").click
    sleep 1
    fill_in "comment_comment", with: "テストコメント"
    find("#comment_comment").native.send_keys(:return)
    sleep 1
    expect(page).to have_selector "p", text:"テストコメント"
    expect(post.reload.comments.size).to eq 1
  end

  scenario "user delete comment other's post", js:true do
    sign_in user
    post = other.posts.create
    photo = post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))
    post.comments.create(user: user, comment: "テストコメント")
    visit user_path(other)
    page.first(".card-img-top").click
    sleep 1
    find(".delete-comment").click
    sleep 1
    expect(page).not_to have_selector "span", text:"テストコメント"
    expect(post.reload.comments.size).to eq 0
  end
end
