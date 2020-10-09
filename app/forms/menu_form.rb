class MenuForm
  include ActiveModel::Model
  attr_accessor :date, :time, :picture, :dishes, :user_id

  validates :date, :time, :user_id, presence: true

  def save
    return false if invalid?

    unless @menu = Menu.find_by(date: date, time: time, user_id: user_id)
      @menu = Menu.new(date: date, time: time, picture: picture, user_id: user_id)
      return false if @menu.invalid?
    end

    dishes_array = []
    dishes.each do |dish_params|
      unless dish_params[:name] == ""
        dish = @menu.dishes.build(dish_params)
        if dish.valid?
          dishes_array << dish
        else
          return false
        end
      end
    end

    dishes_array.each do |d|
      d.save
    end

    true
  end
end
