require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @other = FactoryBot.create(:user)
    @post = @other.posts.create
  end
  it "is valid with user and post" do
    like = Like.new(user: @user, post: @post)
    expect(like).to be_valid
  end
  it "is invalid with duplicate" do
    Like.create(user: @user, post: @post)
    like = Like.new(user: @user, post: @post)
    expect(like).not_to be_valid
  end
end
