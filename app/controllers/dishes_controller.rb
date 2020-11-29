class DishesController < ApplicationController
  before_action :logged_in_user
  before_action :set_menu_times

  def index
    @search_params = dish_search_params
    @dishes = current_user.dishes.search(@search_params)
    @dishes = Kaminari.paginate_array(@dishes).page(params[:page]).per(10)
  end

  private

    def dish_search_params
      params.fetch(:search, {}).permit(:name)
    end
end
