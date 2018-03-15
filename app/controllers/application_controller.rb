class ApplicationController < ActionController::Base
  include MetaTagsManageable

  protect_from_forgery with: :exception
end
