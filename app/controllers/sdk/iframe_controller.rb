class Sdk::IframeController < ApplicationController
  
  def image_simple
    response.headers["X-Frame-Options"] = "ALLOWALL"
    render layout: false
  end


end
