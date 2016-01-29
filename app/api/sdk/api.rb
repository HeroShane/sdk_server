module Sdk
  class API < Grape::API
    mount Sdk::V1::Base
  
  end
end

