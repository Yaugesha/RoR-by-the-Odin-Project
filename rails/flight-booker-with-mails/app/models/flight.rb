class Flight < ApplicationRecord
  belongs_to :arrival_airport, class_name: "Airport"
  belongs_to :departure_airport, class_name: "Airport"

  has_many :bookings, class_name: "Booking", foreign_key: "flight_id", dependent: :destroy

  def flight_start_datetime_formatted
    start_datetime.strftime("%m%d%Y")
  end
end
