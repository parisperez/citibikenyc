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
      choice = params[:is_bike]    
      if choice = true
        @exchange.is_bike = true
      else
        @exchange.is_bike = false
      end
       # binding.pry
      if @exchange.save
     
        render :results
      else
        render :new  
      end
    
  end

  private

  def exchange_params
      params.require(:exchange).permit(:is_bike, :date, :time, :price, :requester_id)
  end

end
