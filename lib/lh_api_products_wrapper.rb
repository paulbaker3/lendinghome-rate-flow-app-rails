require "net/http"
require "net/https"
require "uri"

class LhProductsApiWrapper
  attr_accessor :http,
                :request,
                :response

  def initialize
    uri = URI.parse API_URI

    self.http    = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true
    self.request = Net::HTTP::Get.new uri.request_uri
    request.basic_auth LH_API_USERNAME, LH_API_PASSWORD
  end

  def get_products
    self.response = http.request(request)

    return [] unless successful_response?
    JSON.parse response.body
  end

  def successful_response?
    response.is_a? Net::HTTPOK
  end

  def filter_products loan_application
    products = get_products

    products.reject! { |x| x["first_time_buyer_allowed"] == false } if loan_application.first_time_home_buyer

    filtered = products.select do |x|
      x["state"]                == loan_application.property_state   &&
      x["amount_minimum"]       <= loan_application.requested_amount &&
      x["minimum_credit_score"] <= loan_application.credit_score
    end

    filtered.sort { |a, b| a["rate"] <=> b["rate"] }
  end
end
