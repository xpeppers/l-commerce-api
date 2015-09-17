module FacebookIdentity
  include Koala

  def self.user_id_from(token)
    oauth = Facebook::OAuth.new(FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['app_secret'], nil)
    graph = Facebook::API.new(oauth.get_app_access_token)
    graph.debug_token(token)['data']['user_id']
  end

end
