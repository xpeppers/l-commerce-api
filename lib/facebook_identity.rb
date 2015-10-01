module FacebookIdentity
  include Koala

  def self.user_id_from(token)
    oauth = Facebook::OAuth.new(FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['app_secret'], nil)
    graph = Facebook::API.new(oauth.get_app_access_token)
    graph.debug_token(token)['data']['user_id']
  end

  def self.full_name_from(user_id)
    oauth = Facebook::OAuth.new(FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['app_secret'], nil)
    graph = Facebook::API.new(oauth.get_app_access_token)
    begin
      graph.get_object(user_id)['name']
    rescue
      nil
    end
  end

  def self.profile_picture_url_from(user_id)
    oauth = Facebook::OAuth.new(FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['app_secret'], nil)
    graph = Facebook::API.new(oauth.get_app_access_token)
    begin
      graph.get_picture(user_id, type: 'large')
    rescue
      nil
    end
  end

end
