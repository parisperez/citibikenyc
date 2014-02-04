class Sale < ActiveRecord::Base
  belongs_to :product
  before_create :populate_guid
private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end
end
