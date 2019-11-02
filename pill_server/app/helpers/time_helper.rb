module TimeHelper
    def time_format(num)
        mins = num % 60
        hours = (num - mins) / 60
        am_or_pm = hours >= 12 ? "pm" : "am"
        hours -= 12 if hours > 12
        "#{hours}:#{"%02d" % mins} #{am_or_pm}"
    end

    def h_format(num)
        ((num - num % 60) / 60).to_s
    end

    def m_format(num)
        (num % 60).to_s
    end
end
