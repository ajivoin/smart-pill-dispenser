class PillObserver < ActiveRecord::Observer
    def after_update(pill)
      if weeks_left(pill) <= 1
        text_to_refill_pills("Pill #{pill.name} needs to be refilled.")
      end
    end
  end
