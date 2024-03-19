class BookingsController < ApplicationController

  def new
    p params
    @booking = Booking.new(flight_id: booking_new_params[:id],
                           number_of_passengers: booking_new_params[:number_of_passengers])
    @flight = Flight.find(@booking.flight_id)
    @number_of_passengers = @booking.number_of_passengers

    @number_of_passengers.times { @booking.passengers.build}
  end

  def create
    @booking = Booking.new(booking_create_params)

    @booking.passengers.each { |passenger| passenger.booking = @booking }

    if @booking.save
      redirect_to flights_path
      @booking.passengers.each do |passenger|
        PassengerMailer.with(user: passenger, booking: @booking).confirmation_email.deliver_now
      end
    else
      @booking.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_new_params
    params.require(:flight).permit(:id, :number_of_passengers)
  end

  def booking_create_params
    params.require(:booking).permit(:flight_id, :number_of_passengers, passengers_attributes: [ :id, :name, :email ])
  end

end
