class MenuForm
  include ActiveModel::Model
  attr_accessor :date, :time, :category, :name, :user_id

  validates :date, :time, :category, :name, :user_id, presence: true

  def save
    return false if invalid?
    @menu = Menu.new(date: date, time: time, user_id: user_id)
    @menu.save
    @dish = @menu.dishes.build(category: category, name: name)
    @dish.save
    true
  end
end
