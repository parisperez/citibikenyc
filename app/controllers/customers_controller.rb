class CustomersController < ApplicationController

  def new
  end

  def create
    Stripe.api_key = "sk_test_TuslzVg7qG52KXZXdbKwy7pD"
    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    # binding.pry
    # Create a Customer
    customer = Stripe::Customer.create(
      :card => token,
      :description => params[:email]
      )
    current_user.stripe_customer_id = customer.id
    if current_user.save
      redirect_to user_path(current_user.id), notice: "Customer ID saved."
    end
  end

end  