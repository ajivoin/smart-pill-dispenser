class AddActiveToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :active, :boolean
  end
end
