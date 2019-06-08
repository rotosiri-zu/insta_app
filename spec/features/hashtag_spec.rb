require 'rails_helper'

RSpec.feature "Hashtags", type: :feature do
  given(:photo_path){ Rails.root.join("app", "assets", "images","icon.png") }
  given(:user){ FactoryBot.create(:user) }
  scenario "create new post with hashtag" do
    sign_in user
    expect {
      visit new_post_path
      fill_in "コメントを書く(＃〜でハッシュタグ)", with: "#テスト"
      attach_file photo_path
      click_button "投稿する"
      expect(page).to have_content "投稿が保存されました"
    }.to change{Hashtag.all.size}.by(1)
    visit hashtag_path(hashname: "テスト")
    expect(page).to have_css("img")
  end
end
