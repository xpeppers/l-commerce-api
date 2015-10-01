module Backoffice
  class AuthenticatedController < ApplicationController
    http_basic_authenticate_with name: 'yourusername', password: 'yourusername123'
  end
end
