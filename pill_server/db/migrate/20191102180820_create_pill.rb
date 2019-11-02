class CreatePill < ActiveRecord::Migration[5.2]
  def change
    create_table :pills do |t|
      t.string :name
      t.integer :count
      t.boolean :active
    end
  end
end
