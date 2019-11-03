# frozen_string_literal: true

class Pill < ApplicationRecord
  has_many :schedules
  has_many :histories
end
