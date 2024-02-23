class Airport < ApplicationRecord

  has_many :arrival_flights, class_name: "Flight", foreign_key: "arrival_airport", depependent: :destroy
  has_many :departure_flights, class_name: "Flight", foreign_key: "departure_airport", depependent: :destroy
end
