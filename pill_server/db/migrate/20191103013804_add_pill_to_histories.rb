class AddPillToHistories < ActiveRecord::Migration[5.2]
  def change
    add_reference :histories, :pill, foreign_key: true
  end
end
