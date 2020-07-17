require 'rails_helper'

RSpec.describe Menu, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before {
    @user = create(:michael)
    @menu = build(:menu, user: @user)
    @most_recent = create(:most_recent, user: @user)
  }

  it "is valid" do
    expect(@menu).to be_valid
  end

  context "without user id" do
    before { @menu.user_id = nil }

    it "is invalid" do
      expect(@menu).to be_invalid
    end
  end

  context "without date" do
    before { @menu.date = " " }

    it "is invalid" do
      expect(@menu).to be_invalid
    end
  end

  context "without time" do
    before { @menu.time = " " }

    it "is invalid" do
      expect(@menu).to be_invalid
    end
  end

  it "arranges records in descending order of created_at" do
    expect(Menu.first).to eq(@most_recent)
  end

  context "when menu is destroyed" do

    it "destroy dishes" do
      @menu.save
      @menu.dishes.create!(name: "豚肉")
      expect do
        @menu.destroy
      end.to change(Dish, :count).by(-1)
    end
  end
end
