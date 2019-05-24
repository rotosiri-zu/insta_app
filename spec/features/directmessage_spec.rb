require 'rails_helper'

RSpec.feature "Directmessages", type: :feature do
  given(:user){ FactoryBot.create(:user) }
  given(:other){ FactoryBot.create(:user) }

  scenario "send directmessage" do
    sign_in user
    visit user_path(other)
    click_button "DMを送る"
    expect(page).to have_content other.user_name
    fill_in "direct_message_message", with: "テストメッセージ"
    click_button "Create Direct message"
    visit current_path
    expect(page).to have_content "テストメッセージ"
  end
end
