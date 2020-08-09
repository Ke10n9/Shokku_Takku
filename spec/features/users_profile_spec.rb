require 'rails_helper'

RSpec.feature "UsersProfiles", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  background {
    @user = create(:michael)
    visit user_path(@user)
  }

  scenario "display user name" do
    expect(page).to have_selector("h1", text: @user.name)
  end

  scenario "display image" do
    expect(page).to have_selector("h1>img.gravatar")
  end
end
