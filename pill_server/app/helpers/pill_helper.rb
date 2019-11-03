module PillHelper

    def alert_text(p)
        if p.count == 0
            return "You are out of #{p.name}!"
        end
        if pill_week_total(p) == 0
            return "#{p.count} tablets left"
        end
        if weeks_left(p) == 1 
            return "#{p.count} tablets left, refill or you will run out next week"
        end
        if weeks_left(p) == 0
            return "#{p.count} tablets left, refill or you will run out this week"
        end
        return "#{p.count} tablets left, you will run out in #{weeks_left(p)} weeks"
    end

    def alert_type(p)
        if p.count == 0
            return "alert-danger"
        end
        if pill_week_total(p) == 0
            return "alert-light"
        end
        if weeks_left(p) < 2
            return "alert-warning"
        end
        return "alert-light"
    end
    
    def pill_week_total(p)
        p.schedules.sum{|s| s.day0 + s.day1 + s.day2 + s.day3 + s.day4 + s.day5 + s.day6 }
    end

    def weeks_left(p)
        p.count / pill_week_total(p)
    end
end
