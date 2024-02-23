class FlightsController < ApplicationController

    def index
      @flight = Flight.new
      @departure_options = Airport.all.map { |airport| [airport.code, airport.id] }
      @arrival_options = @departure_options

      @start_datetimes = Flight.all.map { |flight| [Date.parse(flight.start_datetime).to_fs(:long), flight.start_datetime]  }

      @flights = params[:flight] ? Flight.where(flight_search_params) : []

      p @flight

      if @flights
        flash[:success] = "Results found"
      else
        flash[:notice] = "No rasults found"
      end
    end

    private

    def flight_search_params
      params.require(:flight).permit(:departure_airport, :arrival_airport, :start_datetime)
    end
end
