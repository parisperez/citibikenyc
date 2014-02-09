class Exchange < ActiveRecord::Base
  validates :station, :time, :price, presence: true
  has_attached_file :file
  belongs_to :user
  belongs_to :requester,
    :class_name => 'User',
    :primary_key => 'user_id',
    :foreign_key => 'vendor_id'
  belongs_to :vendor,
    :class_name => 'User',
    :primary_key => 'user_id',
    :foreign_key => 'vendor_id'   
    
  has_many :sales
  validates_numericality_of :price,
    greater_than: 49,
    message: "must be at least 50 cents"

  def transform_date
    d = Date.parse(self.date.to_s)
    return "#{Date::MONTHNAMES[d.mon]} #{d.mday}, #{d.year}"
  end

  def transform_time
    return self.time.httpdate.in_time_zone('Eastern Time (US & Canada)')
  end

  def transform_price
    return (self.price.to_f / 10)
  end

  # def set_vendor(exchange, id)
  #   self.vendor_id = current_user.id
  # end

  # def set_requester(exchange, id)
  #   @exchange = Exchange.find_by_id(params[:id])
  #   @exchange.requester_id = current_user.id
  #   @exchange.save!
  # end

end


