# frozen_string_literal: true

namespace :batch do
  desc 'Send text notifications when pills are ready to take'
  task send_messages: :environment do

    # When live, switch to commented out line
    # current_minutes = (Time.now.seconds_since_midnight / 60).to_i
    current_minutes = 24 * 60 / 2 # hard coded to noon because I want to test stuff

    active_schedules = Schedule.where(active: true, time: current_minutes)
    
    # Send message out for pills that are now ready

    if active_schedules.length
      message = "The following pills are ready:\n"
      active_schedules.each do |schedule|
        message += schedule.pill.name + "\n"
        History.create(
          # TODO: Need to properly calculate week number
          week: 0, # Need to figure out how to get current week
          taken: false,
          schedule: schedule
        )
      end
      message.chomp!
    end

    print "Finding reminders\n"

    # Send reminders for untaken pills

    reminder_schedules = Schedule.where(active: true, time: current_minutes - 1)

    if reminder_schedules.length
      potential_reminders = History.where(
        taken: false,
        schedule: reminder_schedules
      )
    end

    if potential_reminders.length
      message += "\n\nYou still haven't taken these pills:\n"
      potential_reminders.each do |history|
        message += history.schedule.pill.name + "\n"
      end
    end

    print message.chomp
  end
end
