class MenuForm
  include ActiveModel::Model

  # concerning :MenuBuilder do
  #   def menu
  #     @menu ||= Menu.new
  #   end
  # end
  #
  # concerning :DishesBuilder do
  #   attr_reader :dishes
  #
  #   def dishes
  #     @dishes_attributes ||= Dish.new
  #   end
  #
  #   def dishes_attributes=(attributes)
  #     @dishes_attributes = Dish.new(attributes)
  #   end
  # end
  #
  # attr_accessor :date, :time, :picture, :user_id
  attr_accessor :date, :time, :picture, :dishes_attributes, :user_id

  validates :date, :time, :user_id, presence: true
  # validates :dishes, uniqueness: true

  def save
    return false if invalid?

    unless @menu = Menu.find_by(date: date, time: time, user_id: user_id)
      @menu = Menu.new(date: date, time: time, picture: picture, user_id: user_id)
      return false if @menu.invalid?
    end

    dishes_array = []
    dishes_attributes.each do |dish_params|
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

  private

    def menu_params
      {
        date: date,
        time: time,
        picture: picture,
        user_id: user_id
      }
    end

    def build_associations
      menu.dishes << dishes
    end
end
