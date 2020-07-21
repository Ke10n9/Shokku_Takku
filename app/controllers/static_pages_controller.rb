class StaticPagesController < ApplicationController
  def home
    @menus = Menu.paginate(page: params[:page])
    @user = User.new
  end
end
