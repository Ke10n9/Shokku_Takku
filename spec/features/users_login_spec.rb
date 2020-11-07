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

    scenario "redirect to @user" do
      expect(page).to have_current_path(root_url)
    end

    scenario "change navbar" do
      expect(page).to_not have_css("a", text: "ログイン")
      expect(page).to have_css("a", text: "ログアウト")
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

    scenario "change menu bar" do
      expect(page).to have_css("a", text: "ログイン")
      expect(page).to_not have_css("a", text: "ログアウト")
      expect(page).to_not have_css("a", text: "プロフィール")
    end
  end
end
