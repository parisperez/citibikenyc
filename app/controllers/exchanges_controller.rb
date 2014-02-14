class ExchangesController < ApplicationController

  self.before_action( :set_exchange, :authorized!, except: [:new, :create, :index] )

  TWILIO_SID = 'AC19f56d8782421ab57fe7ac71d998b714'
  TWILIO_AUTH = 'e6d037c71b9924019d62160d15949bb7'
  TWILIO_NUMBER = "+12132238913"

  def new
      @exchange = Exchange.new  
      render :new
  end

  def update
    @exchange = Exchange.find_by(id: params[:id])
    @comment = Comment.find_by(commentable_id: params[:id])
    @exchange.vendor_id = @comment.commenter_id
    @exchange.price = @comment.counterprice
    @exchange.save
    @vendor = User.find_by(id: @exchange.vendor_id)
    redirect_to exchange_path(@exchange)
     # FOR TWILIO
      @twilio_client = Twilio::REST::Client.new(
      TWILIO_SID,
      TWILIO_AUTH
      )
      @twilio_client.account.sms.messages.create(
      :from => TWILIO_NUMBER,
      :to => "+1#{current_user.phone_number}",
      :body => "Your angel: " + "#{@vendor.username}. Phone: " + "#{@vendor.phone_number}. Address: " + "#{@exchange.station}. " + "Click here: www.sendangel.in/exchanges/#{@exchange.id}",
      )  
      @twilio_client.account.sms.messages.create(
      :from => TWILIO_NUMBER,
      :to => "+1#{@vendor.phone_number}",
      :body => "Your client: " + "#{current_user.username}. Phone: " + "#{current_user.phone_number}. Address: " + "#{@exchange.station}. " + "Click here: www.sendangel.in/exchanges/#{@exchange.id}",
      ) 
  end

  def create
    if current_user.phone_number != nil && current_user.stripe_customer_id.length != 0 && current_user.username.length != 0
      @exchanges = Exchange.all
      @exchange = Exchange.new(exchange_params)  
      @exchange.user = current_user
      time_choice = params[:time]
      if time_choice == "1"
        @exchange.time = Time.now
      elsif time_choice == "2"
        @exchange.time = Time.now + 15*60  
      elsif time_choice == "3"
        @exchange.time = Time.now + 30*60    
      elsif time_choice == "4"
        @exchange.time = Time.now + 45*60  
      end

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

      # FOR STRIPE
      respond_to do |format|
        if @exchange.save
          format.html {
          redirect_to @exchange,
          notice: 'Exchange was successfully created.'
          }
          format.json {
          render json: @exchange,
          status: :created,
          location: @exchange
          }
          # FOR TWILIO
          @twilio_client = Twilio::REST::Client.new(
          TWILIO_SID,
          TWILIO_AUTH
          )
          @twilio_client.account.sms.messages.create(
          :from => TWILIO_NUMBER,
          :to => "+1#{current_user.phone_number}",
          :body => "Wheelie. Your angel request has been created.",
          )
        else
          # FOR STRIPE
          format.html { render 'new' }
          format.json {
          render json: @exchange.errors,
          status: :unprocessable_entity
          }
        end
      end   
    else    
      redirect_to edit_user_registration_path(current_user.id), notice: 'Please verify your phone number and payment info to schedule an exchange.'
    end 
  end

  def show
    @exchange = Exchange.find(params[:id])
    @vendor = User.find_by(id: @exchange.vendor_id)
    @user = User.find_by(id: @exchange.user_id)
    @commentable = @exchange
    @comments = @commentable.comments
    @comment = Comment.new
    @commenters = []
    @comments.each do |comment|   
      @commenters << User.where(id: [comment.commenter_id])
    end
    # binding.pry
    render :show
  end

  def index
    @exchanges = Exchange.all
    render :index
  end

  def rated
    @exchange = Exchange.find(params[:id])
    @exchange.rated = "yes"
    @exchange.save!
    redirect_to user_path(current_user)
  end

  def claim
    @exchange = Exchange.find(params[:id])
    @exchange.vendor_id = current_user.id
    current_user.role = "vendor"
    current_user.save!
    @user = User.find_by(id: @exchange.user_id)
    if @exchange.save
      # FOR TWILIO
      @twilio_client = Twilio::REST::Client.new(
      TWILIO_SID,
      TWILIO_AUTH
      )
      @twilio_client.account.sms.messages.create(
      :from => TWILIO_NUMBER,
      :to => "+1#{@user.phone_number}",
      :body => "Your angel: " + "#{current_user.username}. Phone: " + "#{current_user.phone_number}. Address: " + "#{@exchange.station}. " + "Click here: www.sendangel.in/exchanges/#{@exchange.id}",
      )  
      redirect_to exchange_path(@exchange)

    end
  end

  def destroy
   @exchange = Exchange.find(params[:id])
    if @exchange.destroy
      redirect_to user_path(current_user)
    else 
      render :new
    end
  end
    
  private

  def exchange_params
      params.require(:exchange).permit(:description, :name, :permalink, :price, :file, :is_bike, :date, :time, :price, :station)
  end

  def set_exchange
    @exchange = Exchange.find(params[:id])
  end

  # prevents users from tampering or seeing other user exchanges. 
  def authorized!
    unless @exchange.user_id == current_user.id || @exchange.vendor_id == current_user.id || @exchange.vendor_id == nil
      redirect_to user_path(current_user.id)
    end
  end

end
