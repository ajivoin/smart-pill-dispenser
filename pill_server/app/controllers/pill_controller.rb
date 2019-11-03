class PillController < ApplicationController
    def new
    end

    def create
        @p = Pill.new
        @p.name = params[:name]
        @p.desc = params[:desc]
        @p.count = params[:count].to_i
        @p.save
        redirect_to schedule_url(pill: @p.id)
    end
end
