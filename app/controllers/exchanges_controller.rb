class ExchangesController < ApplicationController

  def new
    @exchange = Exchange.new
    # binding.pry
    render :new
  end

  def create
    # ADDRESS
    # @coordinates = Geocoder.coordinates(params[:address])
    # unless @coordinates.nil?

    #   @coordinates = { latitude: @coordinates[0], longitude: @coordinates[1] }
    #   @all_citibike_stations = Citibikenyc.stations.values[2]

    #   @winning_station = @all_citibike_stations.min_by do |station|
    #     distance_x = @coordinates[:longitude] - station["longitude"]
    #     distance_y = @coordinates[:latitude] - station["latitude"]
    #     Math.hypot( distance_x, distance_y )
    #   end 
    # end  

      # EXCHANGE FORM
      @exchange = Exchange.new(exchange_params)
      binding.pry
      if @exchange.save

        render :results
      else
        render :new  
      end
    
  end

    # def index
    #   redirect_to new_exchange_path
    # end

  private

  def exchange_params
      params.require(:exchange).permit(:is_bike, :date, :time, :price)
  end

end
