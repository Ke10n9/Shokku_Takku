require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before {
    @user = create(:michael)
    @other_user = create(:archer)
    @relationship = Relationship.create(follower_id: @user.id, followed_id: @other_user.id)
  }

  it "is valid" do
    expect(@relationship).to be_valid
  end

  it "require a follower_id" do
    @relationship.follower_id = nil
    expect(@relationship).to be_invalid
  end

  it "require a followed_id" do
    @relationship.followed_id = nil
    expect(@relationship).to be_invalid
  end
end
