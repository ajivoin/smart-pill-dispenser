class AddPillToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_reference :schedules, :pill, foreign_key: true
  end
end
