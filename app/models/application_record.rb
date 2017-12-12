# @abstract
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include BasicScopes
end
