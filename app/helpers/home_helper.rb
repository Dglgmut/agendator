module HomeHelper
  def next_days
    7.times do |x|
      day = (Time.now + x.days)
      yield(day.strftime("%d-%m-%Y"))
    end
  end

  def hours_range
    (6..23).each do |h|
      yield('%02d:00' % h)
    end
  end
end
