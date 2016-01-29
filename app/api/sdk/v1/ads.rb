require 'rack/contrib'

module Sdk
  module V1
    class Ads < Grape::API
      use Rack::JSONP

      helpers do
        def render_template
          css2 = ["swiper.min.css", "swiper_init.css"].map {|_css| "http://localhost:8000/css/#{_css}" }
          js2 = ["swiper.min.js", "swiper_init.js"].map {|_js| "http://localhost:8000/js/#{_js}" }
          t1= Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/image_simple.html.erb")
          t2 = Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/imgae_silder.html.erb")
          t3= Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/image_simple.html.erb")
          {
            html_files: {
              "AD1" => t1.render,
              "AD2" => t2.render,
              "AD3" => t3.render
            },
            css_files: css2,
            js_files: js2
          }
        end
      end

      include Sdk::V1::Default

      # SecureRandom.urlsafe_base64(nil, false) -> LQ55zl84j-wTeC8fHsZvNg

      resource :ads do
        desc "图片 + 超链接"
        get :image_simple do
          template = Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/image_simple.html.erb")
          {html: template.render, css: "http://localhost:8000/css/image_simple.css", js: "http://localhost:8000/js/image_simple.js"}
        end

        desc ""
        post "iframe/image_simple" do
          template = Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/image_simple.html.erb")
          {html: template.render, css: "http://localhost:8000/css/image_simple.css", js: "http://localhost:8000/js/image_simple.js"}
        end

        desc ""
        get "jsonp/image_simple" do
          template = Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/image_simple.html.erb")
          {html: template.render, css: "http://localhost:8000/css/image_simple.css", js: "http://localhost:8000/js/image_simple.js"}
        end

        desc ""
        get :image_swiper do
          css = ["swiper.min.css", "swiper_init.css"].map {|_css| "http://localhost:8000/css/#{_css}" }
          js = ["swiper.min.js", "swiper_init.js"].map {|_js| "http://localhost:8000/js/#{_js}" }
          template = Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/imgae_silder.html.erb")
          {html: template.render, css: css, js: js}  
        end

        desc ""
        post :imgae_multi do 
  
          css1 = "http://localhost:8000/css/image_simple.css"
          js1 = "http://localhost:8000/js/image_simple.js"
          t1= Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/image_simple.html.erb")

          css2 = ["swiper.min.css", "swiper_init.css"].map {|_css| "http://localhost:8000/css/#{_css}" }
          js2 = ["swiper.min.js", "swiper_init.js"].map {|_js| "http://localhost:8000/js/#{_js}" }
          t2 = Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/imgae_silder.html.erb")

          t3= Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/image_simple.html.erb")
          {
            html: {
              "AD1" => t1.render,
              "AD2" => t2.render,
              "AD3" => t3.render
            },
            css: [],
            js: []
          }
        end

        desc ""
        post :sdk_secrete do 
          # css1 = "http://localhost:8000/css/image_simple.css"
          # js1 = "http://localhost:8000/js/image_simple.js"
          # t1= Tilt::ERBTemplate.new("#{Rails.root}/app/views/sdk/pages/image_simple.html.erb")
          access_token_str = params[:access_token]

          if access_token_str
            access_token = JSON.parse(access_token_str)["value"]
            app_key, ts, sign = access_token["app_key"], access_token["timestamp"], access_token["sign"]

            str = "app_key=#{app_key}&timestamp=#{ts}&secret=GVg9ANY2NxMauWC12ZtjPw"
            digest = OpenSSL::Digest.new('sha1')
            decode_str =OpenSSL::HMAC.hexdigest(digest, "GVg9ANY2NxMauWC12ZtjPw", str)
            sign == decode_str ? render_template : {}
          end
        end        


      end # end resource
      
    end
  end
end
