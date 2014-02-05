class TransactionsController < ApplicationController

  skip_before_action :authenticate_user!,
  only: [:new, :create]

  def new
    @exchange = Exchange.find_by!(
      id: params[:id]
      )
  end

  def pickup
    @sale = Sale.find_by!(guid: params[:guid])
    @exchange = @sale.exchange
  end

  def create
    exchange = Exchange.find_by!(
      id: params[:id]
      )
    token = params[:stripeToken]
    begin
      charge = Stripe::Charge.create(
        amount: exchange.price,
        currency: "usd",
        card: token, description: params[:email]
        )
      @sale = exchange.sales.create!(
        email: params[:email]
        )
      redirect_to pickup_url(guid: @sale.guid)
    rescue Stripe::CardError => e
    # The card has been declined or
    # some other error has occurred
    @error = e
    render :new
    end
    binding.pry
  end
  
  def download
    @sale = Sale.find_by!(guid: params[:guid])
    resp = HTTParty.get(@sale.exchange.file.url)
    filename = @sale.exchange.file.url
    send_data resp.body,
    :filename => File.basename(filename),
    :content_type => resp.headers['Content-Type']
  end
end