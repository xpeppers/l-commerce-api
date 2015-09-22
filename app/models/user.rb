class User < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :provider_user_id

  def authenticated?
    not token.nil?
  end
end
