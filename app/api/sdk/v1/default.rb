module Sdk
  module V1
    module Default
      extend ActiveSupport::Concern

      included do 
        version 'v1'
        default_format :json
        format :json
      end

    end
  end
end
