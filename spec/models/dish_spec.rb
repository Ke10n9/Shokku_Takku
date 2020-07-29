require 'rails_helper'

RSpec.describe Dish, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before {
    @user = create(:michael)
    @menu = create(:menu, user: @user)
    @dish = create(:dish, menu: @menu)
  }

  it "is valid" do
    expect(@dish).to be_valid
  end

  context "without menu id" do
    before { @dish.menu_id = nil }

    it "is invalid" do
      expect(@dish).to be_invalid
    end
  end

  context "without name" do
    before { @dish.name = nil }

    it "is invalid" do
      expect(@dish).to be_invalid
    end
  end

  context "with too long name" do
    before { @dish.name = "a" * 31 }

    it "is invalid" do
      expect(@dish).to be_invalid
    end
  end

  context "without category" do
    before { @dish.category = "" }

    it "is invalid" do
      expect(@dish).to be_invalid
    end
  end
end
