class AddOpenHoursToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :open_hrs, :time
    add_column :meals, :close_hrs, :time
    add_column :meals, :open_days, :text
  end
end
