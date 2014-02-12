class CustomersController < ApplicationController
  def create
    Stripe.api_key = "sk_test_tpq7oUZzfNAPjyzD5E8Nln0I"

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a Customer
    customer = Stripe::Customer.create(
      :card => token,
      :description => params[:email]
      )
  end

end  