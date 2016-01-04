module ApplicationHelper
  def weekdays
    Availability::WDAYS.keys
  end

  def weekdays_column_headers
    Availability::WDAYS_COLUMNS
  end
end
