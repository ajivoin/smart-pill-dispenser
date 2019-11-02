class CreateHistory < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.boolean :taken
      t.integer :week_number
    end
  end
end
