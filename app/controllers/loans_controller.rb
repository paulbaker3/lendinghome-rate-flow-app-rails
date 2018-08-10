class LoansController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      user = User.create!(email: params[:email])
      loan = Loan.create!(user: user)
    end

    redirect_to(thank_you_path)
  end
end
