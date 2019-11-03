require "#{Rails.root}/app/helpers/application_helper"
require "#{Rails.root}/app/helpers/time_helper"
include ApplicationHelper
include TimeHelper

namespace :batch do
  desc 'Send text notifications when pills are ready to take'
  task send_messages: :environment do
    time = in_our_timezone(Time.now)
    # When live, switch to commented out line
    current_minutes = (time.seconds_since_midnight / 60).to_i
    # current_minutes = 24 * 60 / 2 # hard coded to noon because I want to test stuff

    active_schedules = Schedule.where(active: true, time: current_minutes)
    
    # Send message out for pills that are now ready
    message = ""
    if active_schedules.present?
      message += "The following pills are ready:\n"
      active_schedules.each do |schedule|
        message += schedule.pill.name + "\n"
        History.create(
          time: time,
          taken: false,
          pill: schedule.pill
        )

        day = time.wday
        day_count = schedule['day' + day.to_s].to_i
        schedule.pill.update(count: schedule.pill.count - day_count)

        JonnyBoi.create(
          count: day_count
        )
      end
      message.chomp!
      text_to_take_pills(message)
    end

    print "Finding reminders\n"

    # Send reminders for untaken pills

     # reminder_schedules = Schedule.where(active: true, time: current_minutes - 1)

    # if reminder_schedules.present?
    #   potential_reminders = History.where(
    #     taken: false,
    #     schedule: reminder_schedules
    #   )
    # end

    potential_reminders = History.where(
      taken: false,
      time: 5.minutes.ago..1.minutes.ago
    )

    if potential_reminders.present?
      message += "\n\nYou still haven't taken these pills:\n"
      potential_reminders.each do |history|
        message += history.pill.name + "\n"
      end
      message.chomp!
      text_to_take_pills(message)
    end
  end
end
