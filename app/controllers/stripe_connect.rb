class StripeConnectController < ApplicationController

  def create
    auth_hash = params[:auth_hash]
    current_user.stripe_id = auth_hash['stripe_user_id']
    current_user.stripe_access_key = auth_hash['access_token']
    current_user.stripe_publishable_key = auth_hash['stripe_publishable_key']
    if current_user.save
      flash[:notice] = "Stripe info saved"
      redirect_to root_path
    else
      redirect_to root_path
      flash[:notice] = "Something went wrong."
    end
    render :new
  end

end