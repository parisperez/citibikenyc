class CustomersController < ApplicationController
  def create
    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a Customer
    customer = Stripe::Customer.create(
      :card => token,
      :description => params[:email]
      )
  end

end  