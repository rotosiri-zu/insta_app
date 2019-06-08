require 'rails_helper'

RSpec.feature "FootStamps", type: :feature do
  given(:true_user) { FactoryBot.create(:user, stamp_true: true) }
  given(:false_user) { FactoryBot.create(:user, stamp_true: false) }

  scenario "should be created if user's config is true" do
    expect do
      sign_in true_user
      visit user_path(false_user)
      sign_in false_user
      visit foot_stamps_user_path(false_user)
      expect(page).to have_content "#{true_user.user_name}からの足跡があります"
    end.to change { FootStamp.where(to_user_id: false_user.id, from_user_id: true_user.id).to_a.size }.by(1)
  end

  scenario "should not be created if user's config is false" do
    expect do
      sign_in false_user
      visit user_path(true_user)
      sign_in true_user
      visit foot_stamps_user_path(true_user)
      expect(page).not_to have_content "#{false_user.user_name}からの足跡があります"
    end.to change { FootStamp.where(to_user_id: false_user.id, from_user_id: true_user.id).to_a.size }.by(0)
  end
end
