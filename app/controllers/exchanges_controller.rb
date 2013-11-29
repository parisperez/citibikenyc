class ExchangesController < ApplicationController

  def new
    render :new
  end

  def create
    # EXCHANGE FORM
    @exchange = Exchange.new
    # choice = params[:choice]
    # if choice == "bike"
    #   is_bike_choice = true
    # else
    #   is_bike_choice = false
    # end 

    # ADDRESS
    @coordinates = Geocoder.coordinates(params[:address])
    unless @coordinates.nil?

      @coordinates = { latitude: @coordinates[0], longitude: @coordinates[1] }
      @all_citibike_stations = Citibikenyc.stations.values[2]

      @winning_station = @all_citibike_stations.min_by do |station|
        distance_x = @coordinates[:longitude] - station["longitude"]
        distance_y = @coordinates[:latitude] - station["latitude"]
        Math.hypot( distance_x, distance_y )
      end 

      render :results
    else
      render :new  
    end

  end

    def index
      redirect_to new_exchange_path
    end

  # private

  # def exchange_params
  #   params.require(:exchange).permit(:is_bike, :date, :time, :price)
  # end

end