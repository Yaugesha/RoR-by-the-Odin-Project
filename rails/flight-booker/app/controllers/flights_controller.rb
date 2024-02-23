class FlightsController < ApplicationController

    def index
      @flight = Flight.new
      @departure_options = Airport.all.map { |airport| [airport.code, airport.id] }
      @arrival_options = @departure_options

      @start_datetimes = Flight.all.map { |flight| Date.parse(flight.start_datetime).to_fs(:long)  }
    end

    def show
      @flight = flight.find(params[:id])
    end

    def create
      @flight = flight.new(params[:flight])
    end

    def update
      @flight = flight.find(params[:id])
    end

    def edit
      @flight = flight.find(params[:id])
    end

    def destroy
      flight = flight.find(params[:id])
    end
end
