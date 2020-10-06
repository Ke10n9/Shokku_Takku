class RecommendedMenusController < ApplicationController
  before_action :set_menu_times
  before_action :set_dish_categories

  def show
    today = Date.today
    @less_dishes = Array.new(@menu_times.size){Array.new(@dish_categories.size-1){Array.new()}}
    recent_menus = Array.new(@menu_times.size){Array.new()}

    for i in 0..@menu_times.size-1 do
      for num in 0..89 do
        menu = Menu.where(user: current_user,
                          date: today-num,
                          time: @menu_times[i][0])
        recent_menus[i] << menu unless menu == ""
      end
    end

    for i in 0..@menu_times.size-1 do
      for j in 0..@dish_categories.size-2 do
        recent_menus[i].each do |recent_menu|
          dishes = Dish.where(menu: recent_menu, category: @dish_categories[j][0])
          dishes.each do |dish|
            @less_dishes[i][j] << dish.name
          end
        end
      end
    end

    @less_dishes.each_with_index do |per_time, i|
      per_time.each_with_index do |per_category, j|
        per_category.uniq!
        per_category.reverse!
        @less_dishes[i][j] = per_category[0..2]
      end
    end
  end
end
