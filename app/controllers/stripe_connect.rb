class StripeConnectController < ApplicationController

  def create
    auth_hash = request.env["omniauth.auth"]
    # auth_hash = params[:auth_hash]
    current_user.stripe_id = auth_hash['uid']
    current_user.stripe_access_key = auth_hash['credentials']['token']
    current_user.stripe_publishable_key = auth_hash['info']['stripe_publishable_key']
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