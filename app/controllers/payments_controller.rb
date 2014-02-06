class PaymentsController < ApplicationController

  skip_before_action :authenticate_user!,
  only: [:new, :create]

  def new
    @user = current_user
  end

  def create
    recipient = Stripe::Recipient.create(
      name: params[:fullName],
      type: 'individual',
      bank_account: params[:stripeToken]
    )
    current_user.update_attributes(:stripe_recipient_id => recipient.id)
    if current_user.stripe_recipient_id != nil
      redirect_to payments_confirm_path
    else
      # this is failing the test. should not go to confirm page.
      render :new
    end
  end

  def confirm
  end

end