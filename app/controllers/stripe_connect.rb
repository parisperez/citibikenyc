class StripeConnectController < ApplicationController

  def create
    auth_hash = params[:auth_hash]
    # current_user.stripe_id = auth_hash['uid']
    current_user.stripe_access_key = auth_hash['access_token']
    # current_user.stripe_publishable_key = auth_hash['info']['stripe_publishable_key']
    raise request.env["omniauth.auth"].to_yaml
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