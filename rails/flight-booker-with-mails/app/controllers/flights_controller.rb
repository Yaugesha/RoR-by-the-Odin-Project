class FlightsController < ApplicationController

    def index
      @flight = Flight.new
      @departure_options = Airport.all.map { |airport| [airport.code, airport.id] }
      @arrival_options = @departure_options

      @start_datetimes = Flight.all.map { |flight| [Date.parse(flight.start_datetime).to_fs(:long), flight.start_datetime]  }

      @flights = params[:flight] ? Flight.where("arrival_airport_id = ? AND departure_airport_id = ?",
                                                params["flight"]["arrival_airport"],
                                                params["flight"]["departure_airport"])
                                          .where(start_datetime:
                                                (Date.parse(params["flight"]["start_datetime"]).midnight..
                                                Date.parse(params["flight"]["start_datetime"])+1.day))
      : []

      if @flights != []
        flash[:success] = "Results found"
      else
        flash[:notice] = "No rasults found"
      end
    end

    private

    def flight_search_params
      params.require(:flight).permit(:departure_airport, :arrival_airport, :start_datetime, :number_of_passengers)
    end
end
