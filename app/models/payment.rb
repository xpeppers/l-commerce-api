class Payment < ActiveRecord::Base
  belongs_to :order

  def capture!
    update_attributes(status: 'captured')
    order.capture!
  end

  def captured?
    status.eql? 'captured'
  end
end
