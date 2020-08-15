class AddPictureToMenus < ActiveRecord::Migration[6.0]
  def change
    add_column :menus, :picture, :string
  end
end
