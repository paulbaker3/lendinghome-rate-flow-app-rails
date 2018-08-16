class MainController < ApplicationController
  def home; end
  def sorry; end


  def thank_you
    products = session[:products].select{ |pr| pr["id"] == params[:product_id].to_i }
    raise "404" unless products.count == 1

    @product = products.first
  end
end
