module CountdownHelper
  def countdown_to(deadline)
    now = Time.current

    return { months: 0, days: 0, hours: 0, minutes: 0, seconds: 0 } if deadline <= now

    months = ((deadline.year - now.year) * 12) + (deadline.month - now.month)
    adjusted = now.advance(months: months)

    if adjusted > deadline
      months -= 1
      adjusted = now.advance(months: months)
    end

    remaining_seconds = (deadline - adjusted).to_i

    days    = remaining_seconds / 1.day
    hours   = (remaining_seconds % 1.day) / 1.hour
    minutes = (remaining_seconds % 1.hour) / 1.minute
    seconds = remaining_seconds % 60

    {
      months: months,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds
    }
  end
end
