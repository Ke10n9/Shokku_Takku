require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  before { @user = create(:michael) }

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
