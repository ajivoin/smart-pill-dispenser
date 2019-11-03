class PillController < ApplicationController
    def new
    end

    def get_pill_counts
        first_4 = JonnyBoi.first(4)
        data = [-1, -1, -1, -1]
        first_4.each_with_index do |jonny_boi, i|
            data[i] = jonny_boi.count
            JonnyBoi.destroy(jonny_boi.id)
        end
        
        render :json => data
    end

    def create
        @p = Pill.new
        @p.name = params[:name]
        @p.desc = params[:desc]
        @p.count = params[:count].to_i
        @p.save
        # render 'schedule'
        redirect_to schedule_url(pill: @p.id)
    end
end
