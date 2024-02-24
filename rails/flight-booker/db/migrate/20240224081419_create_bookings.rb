class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.integer :number_of_passengers

      t.timestamps
    end
  end
end
