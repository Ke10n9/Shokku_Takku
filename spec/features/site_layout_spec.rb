require 'rails_helper'

RSpec.feature "SiteLayouts", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  let(:base_title) { 'Shokku Takku' }

  scenario "click links" do
    visit root_path
    click_link "Shokku Takku"
    expect(page).to have_title base_title
    click_link "Home"
    expect(page).to have_title base_title
  end
end
