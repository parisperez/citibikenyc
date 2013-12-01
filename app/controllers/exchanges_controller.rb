class ExchangesController < ApplicationController

  def new
    @exchange = Exchange.new
    # binding.pry
    render :new
  end

  def create
      @exchanges = Exchange.all
      @exchange = Exchange.new(exchange_params)  
      @exchange.requester_id = current_user.id

      choice = params[":is_bike"]    
      if choice == "true"
        @exchange.is_bike = true
      elsif 
        choice == "false"
        @exchange.is_bike = false
      end

      @coordinates = Geocoder.coordinates(@exchange.station)
      unless @coordinates.nil?

        @coordinates = { latitude: @coordinates[0], longitude: @coordinates[1] }
        @all_citibike_stations = Citibikenyc.stations.values[2]

        @station = @all_citibike_stations.min_by do |station|
          distance_x = @coordinates[:longitude] - station["longitude"]
          distance_y = @coordinates[:latitude] - station["latitude"]
          Math.hypot( distance_x, distance_y )    
        end 
          @exchange.station = @station["label"]
          @exchange.save
      end
    if @exchange.save
     
      redirect_to exchange_path(@exchange)
    else
      render :new  
    end

    def show
      @exchange = Exchange.find_by(id: params[:id])
      render :show
    end

    def index
      @exchanges = Exchange.all
      # @exchange = Exchange.find_by(id: params[:id])

      render :index
    end
    
  end

  private

  def exchange_params
      params.require(:exchange).permit(:is_bike, :date, :time, :price, :requester_id, :station)
  end

end
