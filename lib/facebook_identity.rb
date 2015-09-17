module FacebookIdentity

  def self.user_id_from(token)
    app_id = 'app_id'
    app_secret = 'app_secret'
    oauth = Koala::Facebook::OAuth.new(app_id, app_secret, nil)
    app_access_token = oauth.get_app_access_token
    graph = Koala::Facebook::API.new(app_access_token)
    debug_token = graph.debug_token(token)
    debug_token['data']['user_id']
  end

end
