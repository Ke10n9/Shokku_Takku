require 'rails_helper'

RSpec.describe "Users", type: :request do
  before {
    @user = create(:michael)
    @other_user = create(:archer)
  }

  describe "GET /edit" do

    context "without login user" do
      before { get edit_user_path(@user) }

      it "returns flash[:danger]" do
        expect(flash[:danger]).not_to be_empty
      end

      it "redirect to login page" do
        expect(response).to redirect_to login_path
      end
    end

    context "with other user" do
      before {
        log_in_path @other_user
        get edit_user_path(@user)
      }

      it "not return flash[:danger]" do
        expect(flash[:danger]).to be_nil
      end

      it "redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "PATCH /update" do
    before {
      @default_name = @user.name
      @default_email = @user.email
    }

    let(:update_params) {
      { name: "update_name",
        email: "update_email" }
    }

    context "without login user" do
      before {
        patch user_path(@user), params: { user: :update_params }
      }

      it "don't change @user.name" do
        expect(@user.name).to eq(@default_name)
      end

      it "don't change @user.email" do
        expect(@user.email).to eq(@default_email)
      end

      it "returns flash[:danger]" do
        expect(flash[:danger]).not_to be_empty
      end

      it "redirect to login_path" do
        expect(response).to redirect_to login_path
      end
    end

    context "with other user" do
      before {
        log_in_path @other_user
        patch user_path(@user), params: { user: update_params }
      }

      it "don't change @user.name" do
        expect(@user.name).to eq(@default_name)
      end

      it "don't change @user.email" do
        expect(@user.email).to eq(@default_email)
      end

      it "don't return flash[:danger]" do
        expect(flash[:danger]).to be_nil
      end

      it "redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end

    #WEB経由でadmin属性は変更できない
    it "don't allow the admin attribute to be edited via the web" do
      log_in_path @other_user
      expect(@other_user.admin).to be_falsey
      patch user_path(@other_user), params: { user: { password: "password",
                                          password_confirmation: "password",
                                          admin: true } }
      expect(@other_user.admin).to be_falsey
    end
  end

  describe "GET /index" do
    before {
      @non_admin = @other_user
    }

    context "with non-admin user" do
      before {
        log_in_path @non_admin
        get users_path
      }

      it "redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "DELETE /destroy" do

    context "without login user" do

      it "don't delete an user" do
        expect do
          delete user_path(@user)
        end.to change(User, :count).by(0)
      end

      it "redirect to login_url" do
        delete user_path(@user)
        expect(response).to redirect_to login_url
      end
    end

    context "with non-admin user" do
      before { log_in_path @other_user }

      it "don't delete other user" do
        expect do
          delete user_path(@user)
        end.to change(User, :count).by(0)
      end

      it "redirect to root_url" do
        delete user_path(@user)
        expect(response).to redirect_to root_url
      end
    end
  end
end
