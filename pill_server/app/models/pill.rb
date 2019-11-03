# frozen_string_literal: true

class Pill < ApplicationRecord
  has_many :schedules
end
