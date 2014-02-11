class CustomersController < ApplicationController
  def create
    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a Customer
    customer = Stripe::Customer.create(
      :card => token,
      :description => params[:email]
      )
    customer.process!
    if customer.finished?
      redirect_to user_path(current_user.id), notice: "Your payment info has been saved."
    else
      redirect_to user_path(current_user.id), notice: "There was an issue saving your payment info."
    end
  end

end  