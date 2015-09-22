class User < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :provider_user_id

  def authenticate!(token)
    update_attributes(token: token)
  end

  def authenticated?
    not token.nil?
  end
end
