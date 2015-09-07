class Payment < ActiveRecord::Base
  belongs_to :order

  def capture!
    order.capture!
  end

end
