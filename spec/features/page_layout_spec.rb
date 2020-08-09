require 'rails_helper'

RSpec.feature "PageLayouts", type: :feature do

  feature "root_path" do
    background {
      visit root_path
      @user = create(:michael)
    }

    context "when not logged in" do

      scenario "click_link 'ユーザー登録' and redirect_to signup_path" do
        click_link "ユーザー登録"
        expect(page).to have_current_path signup_path
      end
    end

  end

  feature "header" do
    background { visit root_path }

    scenario "click_link 'Shokku Takku' and redirect_to root_path" do
      click_link "Shokku Takku"
      expect(page).to have_current_path root_path
    end

    scenario "click_link 'ホーム' and redirect_to root_path" do
      click_link "ホーム"
      expect(page).to have_current_path root_path
    end

    context "when an user is not yet logged in" do

      scenario "click_link 'ログイン' and redirect_to login_path" do
        click_link "ログイン"
        expect(page).to have_current_path login_path
      end
    end

    context "when an user is already logged in" do
      background {
        @user = create(:michael)
        log_in_as @user
      }

      scenario "click_link 'ユーザー一覧' and redirect_to users_path" do
        click_link "ユーザー一覧"
        expect(page).to have_current_path users_path
      end

      scenario "click_link 'プロフィール' and redirect_to user_path" do
        find(".dropdown-toggle").click
        click_link "プロフィール"
        expect(page).to have_current_path user_path(@user)
      end

      scenario "click_link 'アカウント編集' and redirect_to edit_user_path" do
        find(".dropdown-toggle").click
        click_link "アカウント編集"
        expect(page).to have_current_path edit_user_path(@user)
      end
    end
  end
end
