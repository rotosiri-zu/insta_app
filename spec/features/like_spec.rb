require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  given(:photo_path){ Rails.root.join("app", "assets", "images","icon.png") }
  given(:user){ FactoryBot.create(:user) }
  given(:other){ FactoryBot.create(:user) }

  scenario "user make like other's post", js:true do
    sign_in user
    post = other.posts.create
    photo = post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))
    visit user_path(other)
    page.first(".card-img-top").click
    sleep 1
    page.first(".love").click
    wait_for_css_appear(".loved") do
      expect(page).to have_css(".loved")
    end
    wait_for_ajax do
      expect(user.reload.likes.size).to eq 1
      expect(post.reload.likes.size).to eq 1
    end
    visit likes_user_path(user)
    within(".card-wrap") do
      expect(page).to have_content post.user.user_name
      expect(page).to have_css(".loved")
    end
    visit liked_user_path(other)
    within(".card-wrap") do
      expect(page).to have_content post.user.user_name
      expect(page).to have_css(".loved")
    end
  end

  scenario "delete like", js:true do
    sign_in user
    post = other.posts.create
    photo = post.photos.create(image: Rack::Test::UploadedFile.new(photo_path))
    post.likes.create(user: user)
    visit user_path(other)
    page.first(".card-img-top").click
    sleep 1
    page.first(".loved").click
    wait_for_css_appear(".love") do
      expect(page).to have_css(".love")
    end
    wait_for_ajax do
      expect(user.reload.likes.size).to eq 0
      expect(post.reload.likes.size).to eq 0
    end
    visit likes_user_path(user)
    expect(page).not_to have_css(".card-wrap")
    visit liked_user_path(other)
    expect(page).not_to have_css(".card-wrap")
  end

end
