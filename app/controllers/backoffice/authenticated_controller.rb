module Backoffice
  class AuthenticatedController < ApplicationController
    http_basic_authenticate_with name: BACKOFFICE['username'], password: BACKOFFICE['password']
  end
end
