module Null
  class Image
    include ActionView::Helpers::AssetUrlHelper

    def url
      'http://via.placeholder.com/300x300'
    end
  end
end
