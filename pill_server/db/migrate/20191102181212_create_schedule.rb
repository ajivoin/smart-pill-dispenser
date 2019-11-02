class CreateSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :day
      t.integer :time
    end
  end
end
