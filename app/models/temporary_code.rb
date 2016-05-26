class TemporaryCode < ActiveRecord::Base
  # belongs_to :user

  validates_presence_of :user_id

  before_create :set_code
  before_create :set_validity


  def set_code
    self.code = (0...6).map { ('A'..'Z').to_a[rand(26)] }.join
  end

  def set_validity
    self.validity = (Time.now + 30.minutes).utc
  end
end
