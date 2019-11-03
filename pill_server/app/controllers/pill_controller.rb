class PillController < ApplicationController
    def new
    end

    def create
        @p = Pill.new
        @p.name = params[:name]
        @p.desc = params[:desc]
        @p.count = params[:count].to_i
        @p.save
        redirect_to root_path(pill: @p.id)
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
