class Order < ActiveRecord::Base
  after_initialize :set_default_status

  belongs_to :user
  has_and_belongs_to_many :offers

  def pending?
    self.status.eql? 'pending'
  end

  private

  def set_default_status
    self.status ||= 'pending'
  end
end
