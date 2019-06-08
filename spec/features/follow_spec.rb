require 'rails_helper'

RSpec.feature "Follows", type: :feature do
  given(:user){ FactoryBot.create(:user) }
  given(:other){ FactoryBot.create(:user) }

  scenario "user follow other" do
    expect{
      sign_in user
      visit user_path(other)
      expect(user.following?(other)).to eq false
      click_button "フォローする"
      expect(page).to have_button "フォロー中"
    }.to change(user.following, :count).by(1).and change(other.followers, :count).by(1)
    expect(page).to have_button "フォロー中"
  end

  scenario "user unfollow other", js:true do
    user.follow(other)
    expect{
      sign_in user
      visit user_path(other)
      expect(user.following?(other)).to eq true
      click_button "フォロー中"
      sleep 1
      click_button "フォローをやめる"
      sleep 1
    }.to change(user.following, :count).by(-1).and change(other.followers, :count).by(-1)
    expect(page).to have_button "フォローする"
  end

  scenario "following/followers page have correct user" do
    sign_in user
    user.follow(other)
    visit following_user_path(user)
    expect(page).to have_content other.user_name
    visit followers_user_path(other)
    expect(page).to have_content user.user_name
  end
end
