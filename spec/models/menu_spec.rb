require 'rails_helper'

RSpec.describe Menu, type: :model do
  before {
    @user = create(:michael)
    @menu = build(:menu, user: @user)
    ["breakfast", "lunch", "dinner"].each do |time|
      (1..4).each do |n|
        create(:"#{time}-#{n}", user: @user)
      end
    end
    create(:"dinner-0", user: @user)
    create(:"lunch-0", user: @user)
    @last = create(:"breakfast-0", user: @user)
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

  context "with duplicate column" do
    before {
      @menu.save
      @duplicate_menu = build(:menu, user: @user)
    }

    it "is invalid" do
      expect(@duplicate_menu).to be_invalid
    end
  end

  it "arranges records in descending order of date and time" do
    expect(Menu.last).to eq(@last)
  end

  context "when menu is destroyed" do

    it "destroy dishes" do
      @menu.save
      @menu.dishes.create!(name: "豚肉", category: "主菜")
      expect do
        @menu.destroy
      end.to change(Dish, :count).by(-1)
    end
  end
end
