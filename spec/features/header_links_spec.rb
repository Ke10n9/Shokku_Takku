require 'rails_helper'

RSpec.feature "HeaderLinks", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  let(:base_title) { 'Shokku Takku' }

  scenario "are clicked" do
    visit root_path
    click_link "Shokku Takku"
    expect(page).to have_title base_title
    click_link "ホーム"
    expect(page).to have_title base_title
  end
end
