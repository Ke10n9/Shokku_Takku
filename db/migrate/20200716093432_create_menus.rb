class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.date :date
      t.string :time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :menus, [:time, :created_at]
    add_index :menus, [:user_id, :date, :time]
  end
end
