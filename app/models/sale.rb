class Sale < ActiveRecord::Base
  belongs_to :exchange
  before_create :populate_guid
  has_paper_trail
  include AASM
  
  aasm column: 'state' do
    state :pending, initial: true
    state :processing
    state :finished
    state :errored
    event :process, after: :charge_card do
      transitions from: :pending, to: :processing
    end

    event :finish do
      transitions from: :processing, to: :finished
    end

    event :fail do
      transitions from: :processing, to: :errored
    end
  end

  def charge_card
    begin
      save!
          # charge customer
        @exchange = Exchange.find_by!(
      id: params[:id]
      )  
      exchange_user = User.find_by(id: @exchange.user_id)
      @customer_id = exchange_user.stripe_customer_id    
      Stripe::Charge.create(
        :amount   => self.amount,
        :currency => "usd",
        :customer => @customer_id
      )
      # charge = Stripe::Charge.create(
      #   amount: self.amount,
      #   currency: "usd",
      #   card: self.stripe_token,
      #   description: self.email,
      #   )
      balance = Stripe::BalanceTransaction.retrieve(charge.balance_transaction)
      self.update(
        stripe_id: charge.id,
        card_expiration: Date.new(charge.card.exp_year, charge.card.exp_month, 1),
        fee_amount: balance.fee
        )
      self.finish!
    rescue Stripe::StripeError => e
      self.update_attributes(error: e.message)
      self.fail!
    end
  end

  private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end
end
