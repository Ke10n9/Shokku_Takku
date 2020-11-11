require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  before { @user = create(:michael) }

  describe "POST /create" do
    context "with remembering login" do
      before {
        post login_path, params: { session: { email: @user.email,
                                              password: @user.password,
                                              remember_me: "1" } }
      }

      it "remember the user" do
        expect(cookies[:remember_token]).to eq(assigns(:user).remember_token)
      end
    end

    context "without remembering login" do
      before {
        post login_path, params: { session: { email: @user.email,
                                              password: @user.password,
                                              remember_me: "1" } }
        delete logout_path
        post login_path, params: { session: { email: @user.email,
                                              password: @user.password,
                                              remember_me: "0" } }
      }

      it "forget the user" do
        expect(cookies[:remember_token]).to be_empty
      end
    end
  end

  describe "DELETE /destroy" do
    context "with login user" do
      before do
        post login_path, params: { session: { email: @user.email,
                                              password: @user.password } }
      end

      it "display error page when the user request logout path twice" do
        delete logout_path
        delete logout_path
        expect(response).to have_http_status "302"
      end
    end
  end
end
