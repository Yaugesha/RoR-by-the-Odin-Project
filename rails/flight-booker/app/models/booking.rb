class Booking < ApplicationRecord
  belongs_to :flight, class_name: "Flight"
  has_many :passengers, class_name: "Passenger", foreign_key: "booking_id", dependent: :destroy

  accepts_nested_attributes_for :passengers
end
