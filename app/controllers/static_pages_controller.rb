class StaticPagesController < ApplicationController
  def home
    @menus = Menu.paginate(page: params[:page])
  end
end
