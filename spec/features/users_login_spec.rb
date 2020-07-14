require 'rails_helper'

RSpec.feature "UsersLogins", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  context "with valid information" do
    background do
      @user = create(:michael)
      visit login_path
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password
      click_button "ログイン"
    end

    scenario "redirect to @user" do
      expect(page).to have_current_path("/users/1")
    end

    scenario "change menu bar" do
      expect(page).to_not have_css("a", text: "ログイン")
      expect(page).to have_css("a", text: "ログアウト")
      expect(page).to have_css("a", text: "プロフィール")
    end

    scenario "logout" do
      find(".dropdown-toggle").click
      click_link "ログアウト"
      expect(page).to have_css("a", text: "ログイン")
      expect(page).to_not have_css("a", text: "ログアウト")
      expect(page).to_not have_css("a", text: "プロフィール")
    end
  end
end
