class Api::V1::Web::BaseController < ActionController::API
  include Api::JwtAuthenticatable
  include Api::Paginatable
end