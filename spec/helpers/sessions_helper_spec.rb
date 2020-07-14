require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
