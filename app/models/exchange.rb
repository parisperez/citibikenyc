class Exchange < ActiveRecord::Base
  validates :station, :date, :time, :price, presence: true
  belongs_to :requester,
    :class_name => 'User',
    :primary_key => 'user_id',
    :foreign_key => 'vendor_id'
  belongs_to :vendor,
    :class_name => 'User',
    :primary_key => 'user_id',
    :foreign_key => 'vendor_id'   

  def transform_date
    d = Date.parse(self.date.to_s)
    return "#{Date::MONTHNAMES[d.mon]} #{d.mday}, #{d.year}"
  end

  # def transform_time
  #   d = Date.parse(self.time.to_s)
  #   return "#{Date::MONTHNAMES[d.day]} #{d.dhr}, #{d.dmin}"
  # end

  # def set_vendor(exchange, id)
  #   self.vendor_id = current_user.id
  # end

  # def set_requester(exchange, id)
  #   @exchange = Exchange.find_by_id(params[:id])
  #   @exchange.requester_id = current_user.id
  #   @exchange.save!
  # end

end


