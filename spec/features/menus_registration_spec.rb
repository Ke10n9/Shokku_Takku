require 'rails_helper'

RSpec.feature "MenusInterfaces", type: :feature do
  background {
    @user = create(:michael)
    log_in_as @user
  }

  


end
