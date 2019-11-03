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

end
