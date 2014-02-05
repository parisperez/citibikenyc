class StripeEvent < ActiveRecord::Base

  validates_uniqueness_of :stripe_id
  def event_object
    event = Stripe::Event.retrieve(stripe_id)
    event.data.object
  end

end
