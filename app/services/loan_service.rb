class LoanService
  NEW_LOAN_PARAMS = [:amount, :credit_score, :first_time_buyer, :state]

  class << self
    def create_new_loan(email, params)
      # TODO: better to do this as a command
      ActiveRecord::Base.transaction do
        # TODO: validate email
        # TODO: this just pukes to the front end, handle that with middleware
        raise "invalid state" unless StateHelper.valid_state?(params[:state])
        user = User.find_or_create_by(email: email)
        loan = Loan.create!(
          user: user,
          amount: params[:amount],
          credit_score: params[:credit_score],
          first_time_buyer: params[:first_time_buyer].present?,
          state: params[:state].upcase,
        )
      end
    end

    # TODO: get platform team to actually use the loan in the API call, not really caller's job
    # TODO: the way this is implemented this could be cached but that's going to take too long
    def get_products(loan)
      avail = products_api_call
      products = avail.select do |pr|
        next if loan.first_time_buyer && !pr["first_time_buyer_allowed"]
        pr["amount_minimum"] <= loan.amount && pr["state"] == loan.state.upcase && pr["minimum_credit_score"] <= loan.credit_score
      end
    end

    def process_products(products)
      products = products.sort{|l, r,| l["rate"] <=> r["rate"]}
      { best: products[0], others: products.slice(1..-1) }
    end

    # This should be a client but this is already taking so long
    def products_api_call
      # TODO: environment variable
      url = "https://k149nsb0yi.execute-api.us-east-1.amazonaws.com/prod/products"
      connection = Faraday.new(url: url)
      connection.basic_auth('timbuk', 'tu')
      response = connection.get('/prod/products')
      JSON.parse(response.body) # TODO: Actually error handle
    end

    def set_product(loan, product)
      loan.term = product["term"]
      loan.rate = product["rate"].to_d
      loan.save!
    end
  end
end
