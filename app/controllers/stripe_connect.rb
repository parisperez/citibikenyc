class StripeConnectController < ApplicationController
  self.before_action( :set_user )

  def create
    auth_hash = params[:auth_hash]
    @user.stripe_id = auth_hash['uid']
    @user.stripe_access_key = auth_hash['credentials']['token']
    @user.stripe_publishable_key = auth_hash['info']['stripe_publishable_key']
    if @user.save
      flash[:notice] = "Stripe info saved"
      redirect_to root_path
    else
      redirect_to root_path
      flash[:notice] = "Something went wrong."
    end
    render :new
  end

private

  def set_user
    @user = current_user
  end

end