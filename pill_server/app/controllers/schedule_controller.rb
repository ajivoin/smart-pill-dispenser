# frozen_string_literal: true

class ScheduleController < ApplicationController
  def show
  end

  def update
    @schedule = Schedule.find_by(id: params[:id])
    @schedule.time = params[:'time(4i)'].to_i * 60 + params[:'time(5i)'].to_i
    @schedule.day0 = params[:day0]
    @schedule.day1 = params[:day1]
    @schedule.day2 = params[:day2]
    @schedule.day3 = params[:day3]
    @schedule.day4 = params[:day4]
    @schedule.day5 = params[:day5]
    @schedule.day6 = params[:day6]
    @schedule.active = true
    @schedule.save
    redirect_to root_url('Xforce_reload': 'trueX', pill: @schedule.pill.id)
  end

  def new
    @schedule = Schedule.new
    @schedule.pill = Pill.find_by(id: params[:id])
    @schedule.time = params[:'time(4i)'].to_i * 60 + params[:'time(5i)'].to_i
    @schedule.day0 = params[:day0]
    @schedule.day1 = params[:day1]
    @schedule.day2 = params[:day2]
    @schedule.day3 = params[:day3]
    @schedule.day4 = params[:day4]
    @schedule.day5 = params[:day5]
    @schedule.day6 = params[:day6]
    @schedule.active = true
    @schedule.save
    redirect_to root_url('Xforce_reload': 'trueX', pill: @schedule.pill.id)
  end

  def remove 
    @schedule = Schedule.find_by(id: params[:id])
    @schedule.destroy
    redirect_to root_url('Xforce_reload': 'trueX', pill: @schedule.pill.id)
  end 

  def reply
  end

  def next
    day = in_our_timezone(Time.now).wday
    schedules = Schedule.all.where("day0 > ?", 0) if day == 0
    schedules = Schedule.all.where("day1 > ?", 1) if day == 1
    schedules = Schedule.all.where("day2 > ?", 2) if day == 2
    schedules = Schedule.all.where("day3 > ?", 3) if day == 3
    schedules = Schedule.all.where("day4 > ?", 4) if day == 4
    schedules = Schedule.all.where("day5 > ?", 5) if day == 5
    schedules = Schedule.all.where("day6 > ?", 6) if day == 6
    schedules = schedules.sort_by{|x| x.time}.reverse()
    time = in_our_timezone(Time.now)
    current_minutes = (time.seconds_since_midnight / 60).to_i

    @next = "tomorrow"
    schedules.each do |s|
      if s.time > current_minutes - 60
        @next = time_format(s.time)
      end
    end

    render layout: false
  end

  def in_our_timezone(time)
    Time.local(*time.to_a)
  end

  def time_format(num)
    mins = num % 60
    hours = (num - mins) / 60
    am_or_pm = hours >= 12 ? "pm" : "am"
    hours -= 12 if hours > 12
    "#{hours}:#{"%02d" % mins} #{am_or_pm}"
  end
end
