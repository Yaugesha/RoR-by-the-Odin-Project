class AddBookingRefToPassenger < ActiveRecord::Migration[7.1]
  def change
    add_reference :passengers, :booking
  end
end
