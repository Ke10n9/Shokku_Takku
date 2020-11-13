require 'rails_helper'

RSpec.describe "AccountActivations", type: :request do

  let(:user) {
    { name: "Example User",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password" }
  }

  before {
    ActionMailer::Base.deliveries.clear
    post users_path, params: { user: user }
    @user = assigns(:user)
  }

  context "with invalid activation_token" do
    it "don't allow login" do
      get edit_account_activation_path("invalid token", email: @user.email)
      expect(@user.reload.activated).to be_falsey
    end
  end

  context "with invalid email" do
    it "don't allow login" do
      get edit_account_activation_path(@user.activation_token, email: 'wrong')
      expect(@user.reload.activated).to be_falsey
    end
  end

  context "with valid values" do
    it "allow login" do
      get edit_account_activation_path(@user.activation_token, email: @user.email)
      expect(@user.reload.activated).to be_truthy
    end
  end
end
