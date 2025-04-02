class ProxyController < ApplicationController
  require 'net/http'
  
  # A04:2021 - Insecure Design. Lack of proper security design, allows unlimited requests without resource validation
  # A10:2021 - Server-Side Request Forgery (SSRF). Allows requests to internal network, Missing URL validation
  def fetch
    url = params[:url]
    response = Net::HTTP.get(URI(url))
    render json: { content: response }
  end
end