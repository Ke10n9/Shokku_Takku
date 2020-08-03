require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "when a request by an user is valid" do

      # it "adds an user" do
      #   expect do
      #     post signup_path, params: { user: attributes_for(:michael) }
      #   end.to change(User, :count).by(1)
      # end
      #
      # it "let users log in automatically after signing up" do
      #   post signup_path, params: { user: attributes_for(:michael) }
      #   expect(response).to redirect_to User.last
      # end
    end
  end

  describe "GET /edit" do
    before {
      @user = create(:michael)
      @other_user = create(:archer)
    }

    context "when not logged in" do
      before { get edit_user_path(@user) }

      it "returns flash[:danger]" do
        expect(flash[:danger]).not_to be_empty
      end

      it "redirect to login page" do
        expect(response).to redirect_to login_path
      end
    end

    context "when the user is wrong" do
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
      @user = create(:michael)
      @other_user = create(:archer)
    }

    context "when not logged in" do
      before {
        patch user_path(@user), params: { user: { name: @user.name,
                                                  email: @user.email } }
      }

      it "returns flash[:danger]" do
        expect(flash[:danger]).not_to be_empty
      end

      it "redirect to login_path" do
        expect(response).to redirect_to login_path
      end
    end

    context "as wrong user" do
      before {
        log_in_path @other_user
        patch user_path(@user), params: { user: { name: @user.name,
                                                  email: @user.email } }
      }

      it "not return flash[:danger]" do
        expect(flash[:danger]).to be_nil
      end

      it "redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end

    context "when the user request the admin attribute to be edited via the web" do
      before { log_in_path @other_user }

      it "not allow it" do
        expect(@other_user.admin).to be_falsey
        patch user_path(@other_user), params: { user: { password: "password",
                                            password_confirmation: "password",
                                            admin: true } }
        expect(@other_user.admin).to be_falsey
      end
    end
  end

  describe "GET /index" do
    before { get users_path }

    context "not logged in" do

      it "redirect to login_url" do
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "DELETE /destroy" do
    before {
      @user = create(:michael)
      @other_user = create(:archer)
    }

    context "when not logged in" do

      it "does not delete an user" do
        expect do
          delete user_path(@user)
        end.to change(User, :count).by(0)
      end

      it "redirect to login_url" do
        delete user_path(@user)
        expect(response).to redirect_to login_url
      end
    end

    context "as non-admin user" do
      before { log_in_path @other_user }

      it "does not delete an user" do
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
