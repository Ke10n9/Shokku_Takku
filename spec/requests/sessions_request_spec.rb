require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do

    # メールアドレスとパスワードが無効なログイン
    context "with invalid information login" do
      before { post login_path,
                    params: { session: { email: "", password: "" } } }

      it "not let user log in" do
        # expect(response).to have_http_status(:success)
        expect(session[:user_id]).to be_nil
      end

      it "display error message" do
        expect(flash[:danger]).to be_truthy
      end

      it "clear the error message when user move to another page" do
        get root_path
        expect(flash[:danger]).to be_falsey
      end
    end

    # メールアドレスが正しく、パスワードが誤っているログイン
    context "with login that invalid password for email" do
      before do
        @user = FactoryBot.create(:user)
        post login_path, params: { session: { email: @user.email,
                                              password: "invalid" } }
      end

      it "not let user log in" do
        # expect(response).to have_http_status(:success)
        expect(session[:user_id]).to be_nil
      end

      it "display error message" do
        expect(flash[:danger]).to be_truthy
      end

      it "clear error message when user move to another page" do
        get root_path
        expect(flash[:danger]).to be_falsey
      end
    end

    # 有効なログイン
    context "with invalid information login" do
      before do
        @user = FactoryBot.create(:user)
        post login_path, params: { session: { email: @user.email,
                                              password: @user.password } }
      end

      it "let user log in" do
        expect(session[:user_id]).not_to be_nil
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      @user = FactoryBot.create(:user)
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
    end
    
    context "requested delete logout_path" do
      before { delete logout_path }

      it "let user log out" do
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
