require 'rails_helper'

RSpec.feature "UsersRelationships", type: :feature do
  background {
    @user = create(:archer)
    @other_user = create(:lana)
    log_in_as @user
  }

  context "that had clicked 'フォローする' in user_path(@other_user)" do
    background {
      visit user_path(@other_user)
      click_button "フォローする"
    }

    scenario "let @user follow @other_user" do
      expect(@user.following?(@other_user)).to be_truthy
    end

    scenario "don't show button of 'フォローする'" do
      visit user_path(@other_user)
      expect(page).not_to have_selector(".btn-primary")
    end

    scenario "show button of 'フォロー中'" do
      visit user_path(@other_user)
      expect(page).to have_selector(".btn-success")
    end
  end

  context "that had clicked 'フォロー中' in user_path(@other_user)" do
    background {
      @user.follow(@other_user)
      visit user_path(@other_user)
      click_button "フォロー中"
    }

    scenario "let @user unfollow @other_user" do
      expect(@user.following?(@other_user)).to be_falsey
    end

    scenario "don't show button of 'フォロー中'" do
      visit user_path(@other_user)
      expect(page).not_to have_selector(".btn-success")
    end

    scenario "show button of 'フォローする'" do
      visit user_path(@other_user)
      expect(page).to have_selector(".btn-primary")
    end
  end
end
