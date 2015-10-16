module Authentication
  extend ActiveSupport::Concern

  included do
    validates :token, uniqueness: true, allow_nil: true
  end

  def authenticate!(token)
    update_attributes(token: token)
  end

  def authenticated?
    not token.nil?
  end

end
