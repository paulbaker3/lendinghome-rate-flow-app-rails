class LoansController < ApplicationController
  helper_method :format_term

  def create
    params.permit! # TODO: is this actually safe? Eh, probably
    loan = LoanService.create_new_loan(params[:email], params.slice(*LoanService::NEW_LOAN_PARAMS))

    redirect_to(rates_path(loan_id: loan.id))
  end

  def rates
    # TODO: use load resource or similar and redirect to 404 if not found
    @loan = Loan.find(params[:loan_id])
    raise "404" unless @loan.present?
    products = LoanService.get_products(Loan.find(params[:loan_id]))
    processed = LoanService.process_products(products)
    session[:products] = products

    redirect_to(sorry_path) unless processed[:best].present?

    @best = processed[:best]
    @others = processed[:others]
  end

  def select_rate
    # TODO: use load resource or similar and redirect to 404 if not found
    loan = Loan.find(params[:loan_id])
    products = session[:products].select{ |pr| pr["id"] == params[:product_id].to_i }
    raise "404" unless loan.present? && products.count == 1
    product = products.first

    LoanService.set_product(loan, product)
    redirect_to(thank_you_path(product_id: product["id"]))
  end

  def format_term(term)
    (term/12).to_i
  end
end
