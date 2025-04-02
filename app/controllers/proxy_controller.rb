class ProxyController < ApplicationController
  require 'net/http'
  
  # A04:2021 - Insecure Design. Lack of proper security design, allows unlimited requests without resource validation
  def fetch
    url = params[:url]
    response = Net::HTTP.get(URI(url))
    render json: { content: response }
  end
end