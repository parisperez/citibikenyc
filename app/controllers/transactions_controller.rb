class TransactionsController < ApplicationController

  skip_before_action :authenticate_user!,
  only: [:new, :create]

  before_filter :strip_iframe_protection

  def iframe
    @exchange = Exchange.find_by!(id: params[:id])
    @sale = Sale.new(exchange_id: @exchange)
  end

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
    @exchange = Exchange.find_by!(
      id: params[:id]
      )
      @vendor = User.find_by(id: @exchange.vendor_id)
      # mark as completed
      @exchange.status = "completed"
      @exchange.save! 
      # charge customer
      exchange_user = User.find_by(id: @exchange.user_id)
      stripe_customer_id = exchange_user.stripe_customer_id 
    # sale record
    sale = @exchange.sales.create(
      amount: @exchange.price * 100,
      sendangel_fee: @exchange.price * 100 * 0.2,
      email: params[:email],
      stripe_token: params[:stripeToken],
      vendor_id: @exchange.vendor_id,
      customer_id: stripe_customer_id
      )
    sale.process!
    if sale.finished?
      redirect_to pickup_url(guid: sale.guid)
    else
      flash.now[:alert] = sale.error
      render :new
    end
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

private

def strip_iframe_protection
  response.headers.delete('X-Frame-Options')
end