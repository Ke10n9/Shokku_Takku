class MenusController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
end
