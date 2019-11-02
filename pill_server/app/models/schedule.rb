class Schedule < ApplicationRecord
    belongs_to :pill
    has_many :histories
end
