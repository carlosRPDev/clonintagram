class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  include Language
  include Error
  include Pagy::Backend
end
