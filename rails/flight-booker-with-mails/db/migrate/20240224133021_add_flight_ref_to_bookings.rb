class AddFlightRefToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :flight
  end
end
