require 'rails_helper'

RSpec.feature "UsersIndices", type: :feature do
  background {
    30.times do |n|
      create(:"user-#{n}")
    end

    @admin = create(:michael)
    @non_admin = create(:archer)
  }

  context "with non_admin user" do
    background {
      log_in_as @non_admin
      visit users_path
    }

    scenario "don't show users_path and redirect_to root_path" do
      expect(page).to have_current_path root_path
    end
  end

  context "with admin user" do
    background {
      log_in_as @admin
      visit users_path
    }

    scenario "show users_path" do
      expect(page).to have_current_path '/users'
    end

    scenario "have_selector 'div.pagination' count: 2" do
      expect(page).to have_selector("div.pagination", count: 2)
    end

    scenario "have a username with a link to user_path" do
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
  end
end
