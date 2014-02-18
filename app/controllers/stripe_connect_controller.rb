class StripeConnectController < ApplicationController

  def create  
    @code = params[:code]
    @response = ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret="sk_test_tpq7oUZzfNAPjyzD5E8Nln0I" -d code=#{@code} -d grant_type=authorization_code`)
    current_user.stripe_access_key = @response['access_token']    
    current_user.stripe_id = @response['stripe_user_id']
    current_user.stripe_publishable_key = @response['stripe_publishable_key']
    if current_user.save
      # binding.pry
      flash[:notice] = "Stripe info saved"
    else
      # redirect_to root_path
      flash[:notice] = "Something went wrong."
    end
    render :new
  end

end

