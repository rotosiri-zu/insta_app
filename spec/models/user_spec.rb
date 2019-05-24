require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, user_name, email, and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("名前は空白にできません")
  end
  it "is invalid without a last name" do
    user = FactoryBot.build(:user, user_name: nil)
    user.valid?
    expect(user.errors[:user_name]).to include("ユーザーネームは空白にできません")
  end
  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("emailは空白にできません")
  end
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "test@mail.com")
    user = FactoryBot.build(:user, email: "test@mail.com")
    user.valid?
    expect(user.errors[:email]).to include("このemailは他の人に既に登録されています")
  end
end
