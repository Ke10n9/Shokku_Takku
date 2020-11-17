require 'rails_helper'

RSpec.feature "PasswordResets", type: :feature do
  background { @user = create(:michael) }

  feature "POST /password_resets" do

    background {
      visit root_path
      click_link "ログイン"
      click_link href: new_password_reset_path
    }

    scenario "redirect_to new_password_reset_path by clicking '#password_reset' in login_path" do
      expect(page).to have_current_path(new_password_reset_path)
    end

    context "with invalid email" do
      background {
        fill_in "メールアドレス", with: ""
        click_button "送信"
      }

      scenario "render password_resets_path" do
        expect(page).to have_current_path(password_resets_path)
      end

      scenario "have_selector '.alert-danger'" do
        expect(page).to have_selector(".alert-danger")
      end
    end

    context "with valid email" do
      background {
        fill_in "メールアドレス", with: @user.email
        click_button "送信"
      }

      scenario "redirect_to root_path" do
        expect(page).to have_current_path(root_path)
      end

      scenario "have_selector '.alert-info'" do
        expect(page).to have_selector(".alert-info")
      end
    end
  end

  feature "GET /password_resets" do
    background {
      # new_password_reset_pathで、@userのメールアドレスを送信
      # 'password_resets/create'のcreate_reset_digestが起動
      @user.reset_token = User.new_token
      @user.update_columns(reset_digest: User.digest(@user.reset_token),
                      reset_sent_at: Time.zone.now)
    }

    context "with invalid email" do
      background {
        visit edit_password_reset_path(@user.reset_token, email: "")
      }

      scenario "is failure" do
        expect(page).to have_current_path(root_path)
      end
    end

    context "with invalid reset_token" do
      background {
        visit edit_password_reset_path("wrong token", email: @user.email)
      }

      scenario "is failure" do
        expect(page).to have_current_path(root_path)
      end
    end

    context "with valid values" do
      background {
        # 送信されたメールからパスワードリセット画面にアクセス
        visit edit_password_reset_path(@user.reset_token, email: @user.email)
      }

      scenario "is success" do
        expect(page).to have_current_path(edit_password_reset_path(@user.reset_token, email: @user.email))
      end
    end
  end

  feature "UPDATE /password_resets" do
    background {
      # new_password_reset_pathで、@userのメールアドレスを送信
      # 'password_resets/create'のcreate_reset_digestが起動
      @user.reset_token = User.new_token
      @user.update_columns(reset_digest: User.digest(@user.reset_token),
                      reset_sent_at: Time.zone.now)
      visit edit_password_reset_path(@user.reset_token, email: @user.email)
    }

    context "with invalid password and password_confirmation" do
      background {
        fill_in "新しいパスワード", with: "foobar"
        fill_in "新しいパスワード（再確認）", with: "password"
        click_button "更新"
      }

      scenario "render edit_password_reset_path" do
        expect(page).to have_current_path(password_reset_path(@user.reset_token))
      end
    end

    context "with empty password and password_confirmation" do
      background {
        fill_in "新しいパスワード", with: ""
        fill_in "新しいパスワード（再確認）", with: ""
        click_button "更新"
      }

      scenario "render edit_password_reset_path" do
        expect(page).to have_current_path(password_reset_path(@user.reset_token))
      end
    end

    context "with valid password and password_confirmation" do
      background {
        @password = "foobar"
        fill_in "新しいパスワード", with: @password
        fill_in "新しいパスワード（再確認）", with: @password
        click_button "更新"
      }

      scenario "login user" do
        expect(page).to have_css(".sub-title", text: @user.name)
      end

      scenario "redirect_to root_path" do
        expect(page).to have_current_path(root_path)
      end

      scenario "have_selector '.alert-success'" do
        expect(page).to have_selector(".alert-success")
      end
    end
  end
end
