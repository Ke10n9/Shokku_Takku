require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    # 無効なリクエスト
    context "with invalid request" do
      # 無効なデータを作成
      let(:user_params) {
        { name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar" }
      }
      # ユーザーが追加されない
      it "does not add a user" do
        expect do
          post signup_path, params: { user: user_params }
        end.to change(User, :count).by(0)
      end
    end
    # 有効なリクエスト
    context "with valid request" do

      it "adds a user" do
        expect do
          post signup_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it "let users log in automatically after signing up" do
        post signup_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end
  end

end
