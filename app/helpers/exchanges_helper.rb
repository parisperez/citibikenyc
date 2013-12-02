module ExchangesHelper

  def set_vendor(exchange, id)
    exchange.vendor_id = current_user.id
    exchange.save
  end

  def set_requester(exchange, id)
    exchange = Exchange.find_by_id(params[:id])
    exchange.requester_id = current_user.id
    exchange.save
  end
end