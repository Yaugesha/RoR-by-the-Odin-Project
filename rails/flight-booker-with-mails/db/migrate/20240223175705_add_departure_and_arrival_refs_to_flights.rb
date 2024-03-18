class AddDepartureAndArrivalRefsToFlights < ActiveRecord::Migration[7.1]
  def change
    add_reference :flights, :arrival_airport
    add_reference :flights, :departure_airport
  end
end
