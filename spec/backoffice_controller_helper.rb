module BackofficeControllerHelper
  def authenicate_reseller!
    username = BACKOFFICE['username']
    password = BACKOFFICE['password']
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end
end
