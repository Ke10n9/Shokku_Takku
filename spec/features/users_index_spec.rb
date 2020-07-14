require 'rails_helper'

RSpec.feature "UsersIndices", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  background {
    30.times do |n|
      create(:"user-#{n}")
    end
  }

  context "as admin user" do
    background {
      @admin = create(:michael)
      log_in_as @admin
      visit users_path
    }

    scenario "have pagination" do
      expect(page).to have_selector("div.pagination", count: 2)
    end

    scenario "display user.name and its link is user_path(user)" do
      User.paginate(page: 1).each do |user|
        expect(page).to have_link(user.name, href: user_path(user))
      end
    end

    scenario "display delete text and its link is user_path(user)" do
      User.paginate(page: 1).each do |user|
        unless user == @admin
          expect(page).to have_link("delete", href: user_path(user))
        end
      end
    end
  end

  context "as non-admin user" do
    background {
      @non_admin = create(:archer)
      log_in_as @non_admin
      visit users_path
    }

    scenario "have pagination" do
      expect(page).to have_selector("div.pagination", count: 2)
    end

    scenario "display user.name and its link is user_path(user)" do
      User.paginate(page: 1).each do |user|
        expect(page).to have_link(user.name, href: user_path(user))
      end
    end

    scenario "not display delete link" do
      User.paginate(page: 1).each do |user|
        unless user == @admin
          expect(page).not_to have_link("delete", href: user_path(user))
        end
      end
    end
  end
end
