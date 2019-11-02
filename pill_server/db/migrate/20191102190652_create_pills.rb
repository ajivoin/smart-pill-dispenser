# frozen_string_literal: true

class CreatePills < ActiveRecord::Migration[5.2]
  def change
    create_table :pills do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end
