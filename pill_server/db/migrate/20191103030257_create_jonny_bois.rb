class CreateJonnyBois < ActiveRecord::Migration[5.2]
  def change
    create_table :jonny_bois do |t|
      t.integer :count

      t.timestamps
    end
  end
end
