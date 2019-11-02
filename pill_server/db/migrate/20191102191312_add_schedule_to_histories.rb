# frozen_string_literal: true

class AddScheduleToHistories < ActiveRecord::Migration[5.2]
  def change
    add_reference :histories, :schedule, foreign_key: true
  end
end
