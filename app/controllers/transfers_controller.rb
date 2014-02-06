class TransfersController < ApplicationController

  skip_before_action :authenticate_user!,
  only: [:new, :create]

  def new
    @user = current_user
  end

  def create
    transfer = Stripe::Transfer.create(
      amount: 100,
      currency: 'usd',
      recipient: user.stripe_recipient_id,
      description: 'Transfer'
    )
    render :transfer
  end

  def confirm
  end

end