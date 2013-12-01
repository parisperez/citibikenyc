module ExchangesHelper

  def set_vendor(exchange, id)
    exchange.vendor_id = current_user.id
    exchange.save
  end

end