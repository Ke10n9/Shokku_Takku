class DishesController < ApplicationController
  before_action :logged_in_user
  before_action :set_menu_times

  def index
    @search_params = dish_search_params
    @dishes = current_user.dishes.search(@search_params).paginate(page: params[:page], per_page: 5)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def dish_search_params
      params.fetch(:search, {}).permit(:name)
    end
end
