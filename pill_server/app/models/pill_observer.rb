class PillObserver < ActiveRecord::Observer
    include PillHelper
    include ApplicationHelper
    def after_update(pill)
        if pill_week_total(pill) == 0 || weeks_left(pill) <= 1
        text_to_refill_pills("Pill #{pill.name} needs to be refilled.")
        end
    end
end
