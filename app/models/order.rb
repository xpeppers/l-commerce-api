class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :offers

  after_initialize :set_default_status

  def set_default_status
    self.status = 'pending'
  end
end
