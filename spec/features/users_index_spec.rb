require 'rails_helper'

RSpec.feature "UsersIndices", type: :feature do
  background {
    30.times do |n|
      create(:"user-#{n}")
    end
    @admin = create(:michael)
    @non_admin = create(:archer)
  }

  context "with non-admin user" do
    background {
      log_in_as @non_admin
      visit users_path
    }

    scenario "show img.gravatar" do
      expect(page).to have_selector("img.gravatar")
    end

    scenario "show current_user.name with a link to user_path" do
      expect(page).to have_link(@non_admin.name, href: user_path(@non_admin))
    end

    scenario "show a link to current_user's following_user_path" do
      expect(page).to have_link(href: following_user_path(@non_admin))
    end

    scenario "show number of current_user's following" do
      expect(page).to have_selector("#following", text: @non_admin.following.count)
    end

    scenario "show a link to current_user's followers_user_path" do
      expect(page).to have_link(href: followers_user_path(@non_admin))
    end

    scenario "show number of current_user's followers" do
      expect(page).to have_selector("#followers", text: @non_admin.followers.count)
    end

    scenario "show user search form" do
      expect(page).to have_selector(".search-form")
    end
  end

  # context "without word in search form" do
  #   background {
  #     fill_in "search_name", with: ""
  #     click_button "検索"
  #   }
  #
  #   scenario "show error message" do
  #     wait_for_ajax do
  #       expect(page).to have_selector("#error-user-search")
  #     end
  #   end
  # end

  # context "with non perfect matching user name in search form" do
  #   background {
  #     fill_in "search_name", with: "user"
  #   }
  #
  #   scenario "don't show search results" do
  #     expect(page).to have_selector("#search-results")
  #   end
  # end

  context "with admin user" do
    background {
      log_in_as @admin
      visit users_path
    }

    scenario "have each user.name with a link to user_path" do
      User.paginate(page: 1).each do |user|
        expect(page).to have_link(user.name, href: user_path(user))
      end
    end

    scenario "have a delete link for each user" do
      User.paginate(page: 1).each do |user|
        unless user == @admin
          expect(page).to have_link("delete", href: user_path(user))
        end
      end
    end

    scenario "delete a user when click 'delete'" do
      expect do
        first(:link, 'delete').click
      end.to change(User, :count).by(-1)
    end

    scenario "have paginate" do
      expect(page).to have_css(".pagination")
    end
  end
end
