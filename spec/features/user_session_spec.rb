require 'rails_helper'

RSpec.feature "UserSessions", type: :feature do
  scenario "new user register" do
    visit new_user_registration_path
    user = FactoryBot.build(:user)
    fill_in "メールアドレス", with: user.email
    fill_in "名前" , with: user.name
    fill_in "ユーザーネーム", with: user.user_name
    fill_in "パスワード", with: user.password
    fill_in "パスワードの確認", with: user.password
    click_button "登録する"
    expect(page).to have_content "アカウント登録を受け付けました。"
  end
end
