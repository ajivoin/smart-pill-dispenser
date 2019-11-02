class AddScheduleToHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :schedule, :reference
  end
end
