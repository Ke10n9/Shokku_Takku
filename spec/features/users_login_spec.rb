require 'rails_helper'

RSpec.feature "UsersLogins", type: :feature do
  background { @user = create(:michael) }

  context "when an user login with invalid information" do
    background do
      visit login_path
      click_button "ログイン"
    end

    scenario "redirect to login_path" do
      expect(page).to have_current_path(login_path)
    end

    scenario "display flash message" do
      expect(page).to have_selector(".alert-danger")
    end
  end

  context "when an user login with valid information" do
    background do
      visit login_path
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password
      click_button "ログイン"
    end

    scenario "redirect to root_url" do
      expect(page).to have_current_path(root_url)
    end

    scenario "have_css 'ホーム' in navbar" do
      expect(page).to have_css("a", text: "ホーム")
    end

    scenario "have_css 'ログアウト' in navbar" do
      expect(page).to have_css("a", text: "ログアウト")
    end

    scenario "don't have_css 'ログイン' in navbar" do
      expect(page).to_not have_css("a", text: "ログイン")
    end
  end

  context "when an user logout" do
    background do
      log_in_as @user
      find(".navbar-toggle").click
      click_link "ログアウト"
    end

    scenario "redirect to root_url" do
      expect(page).to have_current_path(root_url)
    end

    scenario "have_css 'ログイン' in navbar" do
      expect(page).to have_css("a", text: "ログイン")
    end

    scenario "don't have_css 'ログアウト' in navbar" do
      expect(page).not_to have_css("a", text: "ログアウト")
    end
  end
end
