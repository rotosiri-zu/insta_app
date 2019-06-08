require 'rails_helper'

RSpec.feature "UserSessions", type: :feature do
  scenario "new user register" do
    visit new_user_registration_path
    user = FactoryBot.build(:user)
    fill_in "メールアドレス", with: user.email
    fill_in "名前", with: user.name
    fill_in "ユーザーネーム", with: user.user_name
    fill_in "パスワード", with: user.password
    fill_in "パスワードの確認", with: user.password
    click_button "登録する"
    expect(page).to have_content "アカウント登録を受け付けました。"
  end

  scenario "invalid user register" do
    visit new_user_registration_path
    fill_in "メールアドレス", with: "invalid@mail.com"
    fill_in "名前", with: "invalid_name"
    fill_in "ユーザーネーム", with: "invalid_user_name"
    fill_in "パスワード", with: "hogehoge"
    fill_in "パスワードの確認", with: "foobar"
    click_button "登録する"
    expect(page).to have_content "この user を保存できません"
  end

  scenario "edit user's profile" do
    user = FactoryBot.create(:user)
    sign_in user
    visit edit_user_registration_path
    fill_in "ウェブサイト", with: "ウェブサイト"
    fill_in "自己紹介", with: "自己紹介"
    fill_in "電話番号", with: "000-0000-0000"
    select  "男性", from: "性別"
    fill_in "現在のパスワード", with: user.password
    click_button "変更する"
    expect(page).to have_content "アカウントが更新されました。"
    expect(user.reload.website).to eq "ウェブサイト"
    expect(user.reload.bio).to eq "自己紹介"
    expect(user.reload.phone_number).to eq "000-0000-0000"
    expect(user.reload.sex).to eq "男性"
  end
end
