class Api::V1::Web::BaseController < Api::ApiController
  include Api::JwtAuthenticatable
  include Api::PaginateAndSortable
end
