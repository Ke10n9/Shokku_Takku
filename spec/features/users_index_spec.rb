require 'rails_helper'

RSpec.feature "UsersIndices", type: :feature do
  background {
    30.times do |n|
      create(:"user-#{n}")
    end
  }

  context "as admin user" do
    background {
      @admin = create(:michael)
      log_in_as @admin
    }

    scenario "visit users_path and delete user" do
      visit users_path
      expect(page).to have_current_path '/users'
      expect(page).to have_selector("div.pagination", count: 2)
      User.paginate(page: 1).each do |user|
        expect(page).to have_link(user.name, href: user_path(user))
        unless user == @admin
          expect(page).to have_link("delete", href: user_path(user))
        end
      end
      expect do
        first(:link, 'delete').click
      end.to change(User, :count).by(-1)
    end
  end
end
