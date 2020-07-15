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
    context "when a request by an user is invalid" do
      # 無効なデータを作成
      let(:user_params) {
        { name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar" }
      }
      # ユーザーが追加されない
      it "does not add an user" do
        expect do
          post signup_path, params: { user: user_params }
        end.to change(User, :count).by(0)
      end
    end
    # 有効なリクエスト
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

    context "when logged in" do
      before {
        log_in_path @user
        get edit_user_path(@user)
      }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when not logged in" do
      before { get edit_user_path(@user) }

      it "returns flash[:danger]" do
        expect(flash[:danger]).not_to be_empty
      end

      it "redirect to login page" do
        expect(response).to redirect_to login_path
      end

      it "session[:forwarding_url] = edit_user_url(@user) before user log in" do
        expect(session[:forwarding_url]).to eq(edit_user_url(@user))
      end

      it "redirect to edit_user_path after user log in" do
        log_in_path @user
        expect(response).to redirect_to edit_user_url(@user)
      end

      it "session[:forwarding_url] is nil after user log in" do
        log_in_path @user
        expect(session[:forwarding_url]).to be_nil
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

    context "when logged in" do
      before {
        log_in_path @user
      }

      context "with invalid request" do
        before {
          patch user_path(@user), params: { user: { name: "",
                                                    email: "foo@invalid",
                                                    password: "foo",
                                                    password_confirmation: "bar" } }
        }

        it "render to users/edit" do
          expect(response).to render_template 'users/edit'
        end
      end

      context "with valid request" do
        before {
          @name = "Foo Bar"
          @email = "foo@bar.com"
          patch user_path(@user), params: { user: { name: @name,
                                                    email: @email,
                                                    password: "",
                                                    password_confirmation: "" } }
          @user.reload
        }

        it "display flash message" do
          expect(flash[:success]).to be_truthy
        end

        it "redirect to @user" do
          expect(response).to redirect_to @user
        end

        it "change @user.name" do
          expect(@user.name).to eq(@name)
        end

        it "change @user.email" do
          expect(@user.email).to eq(@email)
        end
      end
    end

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
