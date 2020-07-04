require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = FactoryBot.build(:user)
  end

  it "is valid" do
    expect(@user).to be_valid
  end

  # nameが無ければ無効
  context "without name" do
    it "is invalid" do
      @user.name = nil
      expect(@user.valid?).to eq(false)
    end
  end

  context "without email" do
    it "is invalid" do
      @user.email = nil
      expect(@user.valid?).to eq(false)
    end
  end

  context "with too long name" do
    it "is invalid" do
      @user.name = "a" * 51
      expect(@user.valid?).to eq(false)
    end
  end

  context "with too long email" do
    it "is invalid" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user.valid?).to eq(false)
    end
  end

  context "with email in valid format" do
    it "is valid" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        expect(FactoryBot.build(:user, email: valid_address)).to be_valid
      end
    end
  end

  context "with email in invalid format" do
    it "is invalid" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
      end
    end
  end

  context "with duplicate email" do
    it "is invalid" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).to be_invalid
    end
  end

  it "email is saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(@user.reload.email).to eq(mixed_case_email.downcase)
  end

  context "without password" do
    it "is invalid" do
      @user.password = @user.password_confirmation = " " * 6
      expect(@user.valid?).to eq(false)
    end
  end

  context "with too short password" do
    it "is invalid" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user.valid?).to eq(false)
    end
  end
end
