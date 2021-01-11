require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do

  describe "current_user" do
    before {
      @user = create(:michael)
      remember(@user)
    }

    context "with nil session" do
      it "returns right user and log user in" do
        expect(current_user).to eq(@user)
        expect(session[:user_id]).not_to be_nil
      end
    end

    context "with wrong remember digest" do
      before {
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
      }

      it "returns nil" do
        expect(current_user).to be_nil
      end
    end
  end

end
