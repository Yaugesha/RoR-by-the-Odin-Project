class Flight < ApplicationRecord
  belongs_to :arrival_airport, class_name: "Airport"
  belongs_to :departure_airport, class_name: "Airport"

  def flight_start_datetime_formatted
    start_datetime.strftime("%m%d%Y")
  end
end
