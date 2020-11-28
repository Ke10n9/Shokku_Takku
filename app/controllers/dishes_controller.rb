class DishesController < ApplicationController
  before_action :logged_in_user

  def index
    @search_params = dish_search_params
    @dishes = current_user.dishes.search(@search_params)

  end

  private

    def dish_search_params
      params.fetch(:search, {}).permit(:name)
    end
end
