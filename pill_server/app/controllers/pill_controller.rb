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

    # Only POST an integer please. Thank you. Have a great day.
    def post_taken
        # Need to set all outstanding pills as taken
        History.where(taken: false).update_all(taken: true) if params[:taken].to_i == 1
        render :json => 'success'
    end

    def create
        @p = Pill.new
        @p.name = params[:name]
        @p.desc = params[:desc]
        @p.count = params[:count].to_i
        @p.save
        redirect_to root_url('Xforce_reload': 'trueX', pill: @p.id)
    end

    def history
        @histories = History.all.sort_by{|x| x.time}.reverse()
        if params[:pill].present?
            @histories = History.all.where(pill: Pill.find_by(id: params[:pill])).sort_by{|x| x.time}.reverse()
        end
    end

    def edit
        @p = Pill.find(params[:id])
    end

    def update
        @p = Pill.find(params[:id])
        @p.name = params[:name]
        @p.desc = params[:desc]
        @p.count = params[:count].to_i
        @p.save
        redirect_to root_path(pill: @p.id)
    end
    
end
