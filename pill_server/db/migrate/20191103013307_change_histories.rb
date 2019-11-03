class ChangeHistories < ActiveRecord::Migration[5.2]
  def change
    remove_column :histories, :schedule_id
    remove_column :histories, :week
    add_column :histories, :time, :datetime 
  end
end
