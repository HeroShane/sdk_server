require 'rack/cors'

module Sdk
  module V1
    class Base < Grape::API

      helpers do

        def forbidden_origin_error!
          error!({ error: '当前请求不合法!' }, 403, { 'Content-Type' => 'text/error' }) 
        end

        def token_match_error!
          error!({ error: '当前请求token不匹配!' }, 403, { 'Content-Type' => 'text/error' }) 
        end

        def token_blank_error!
          error!({ error: 'token不能为空!' }, 403, { 'Content-Type' => 'text/error' }) 
        end

        def request_in_whitelist? origin
          ["client.xrk.com"].include? origin
        end

        def is_token_mapping? token, domain
          resources = resource_mapping[token]
          return false if resources.blank?
          resources.include? domain
        end

        def resource_mapping
          {
            "LQ55zl84j-wTeC8fHsZvNg" => ["client.xrk.com"]
          }
        end

        def uri_host link
          URI(link).host
        end

      end

      # before do 
      #   # request.headers["Referer"] -> http://client.xrk.com/sdk/client/image_simple
      #   # request.headers["Origin"] -> http://client.xrk.com
      #   # request.headers["Xrkad-Request-Token"] -> LQ55zl84j-wTeC8fHsZvNg
      #   iframe_origin = request.headers["Xrkad-Request-Origin"]
      #   if params["callback"].present?
      #     referer = request.headers["Referer"]
      #     host = URI(referer).host
      #   elsif iframe_origin.present?
      #     host = URI(iframe_origin).host
      #   else
      #     xrk_origin = request.headers["Origin"]
      #     forbidden_origin_error! if xrk_origin.blank?
      #     host = URI(xrk_origin).host
      #   end

      #   forbidden_origin_error! unless request_in_whitelist?(host)

      #   token  = request.headers["Xrkad-Request-Token"] || params["token"]
      #   token_blank_error! if token.blank?
      #   # domain = origin.match(/http[s]?:\/\/(client\.xrk\.com)/i).try(:captures)[0]

      #   token_match_error! unless is_token_mapping?(token, host) 
      # end

      mount Sdk::V1::Ads

      
    end
  end
end
