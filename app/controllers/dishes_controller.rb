class DishesController < ApplicationController

  def index
    @search_params =dish_search_params
    @dishes = Dish.search(@search_params)
  end

  private

    def dish_search_params
      params.fetch(:search, {}).permit(:name)
    end
end
