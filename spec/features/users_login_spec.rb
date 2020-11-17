require 'rails_helper'

RSpec.feature "UsersLogins", type: :feature do
  background {
    @user = create(:michael)
    @non_activate = create(:non_activate)
  }

  context "without login user" do
    background do
      visit root_path
      click_link "ログイン"
    end

    scenario "redirect_to login_path" do
      expect(page).to have_current_path(login_path)
    end

    context "filled in invalid values" do
      background {
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: ""
        click_button "ログイン"
      }

      scenario "show css '.sub-title' text: '-献立記録サービス-'" do
        expect(page).to have_css(".sub-title", text: "-献立記録サービス-")
      end

      scenario "render login_path" do
        expect(page).to have_current_path(login_path)
      end

      scenario "show selector '.alert-danger'" do
        expect(page).to have_selector(".alert-danger")
      end
    end

    context "filled in invalid email" do
      background {
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: @user.password
        click_button "ログイン"
      }

      scenario "show css '.sub-title' text: '-献立記録サービス-'" do
        expect(page).to have_css(".sub-title", text: "-献立記録サービス-")
      end

      scenario "render login_path" do
        expect(page).to have_current_path(login_path)
      end

      scenario "show selector '.alert-danger'" do
        expect(page).to have_selector(".alert-danger")
      end
    end

    context "filled in invalid password" do
      background {
        fill_in "メールアドレス", with: @user.email
        fill_in "パスワード", with: ""
        click_button "ログイン"
      }

      scenario "show css '.sub-title' text: '-献立記録サービス-'" do
        expect(page).to have_css(".sub-title", text: "-献立記録サービス-")
      end

      scenario "render login_path" do
        expect(page).to have_current_path(login_path)
      end

      scenario "show selector '.alert-danger'" do
        expect(page).to have_selector(".alert-danger")
      end
    end

    context "filled in valid values" do
      background {
        fill_in "メールアドレス", with: @user.email
        fill_in "パスワード", with: @user.password
        click_button "ログイン"
      }

      scenario "login user" do
        expect(page).to have_css(".sub-title", text: @user.name)
      end

      scenario "render root_path" do
        expect(page).to have_current_path(root_path)
      end

      scenario "show selector '.alert-success'" do
        expect(page).to have_selector(".alert-success")
      end
    end

    context "filled in non_activate user" do
      background {
        fill_in "メールアドレス", with: @non_activate.email
        fill_in "パスワード", with: @non_activate.password
        click_button "ログイン"
      }

      scenario "redirect_to root_path" do
        expect(page).to have_current_path(root_path)
      end

      scenario "show selector '.alert-warning'" do
        expect(page).to have_selector(".alert-warning")
      end

      scenario "show css '.sub-title' text: '-献立記録サービス-'" do
        expect(page).to have_css(".sub-title", text: "-献立記録サービス-")
      end
    end
  end

  context "with login user" do
    background do
      log_in_as @user
      visit root_path
    end

    scenario "logout the user when the user click 'ログアウト'" do
      click_link "ログアウト"
      expect(page).to have_css(".sub-title", text: "-献立記録サービス-")
    end
  end
end
