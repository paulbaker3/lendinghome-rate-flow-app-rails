class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
    @user.loan ||= Loan.new
    @products = LhProductsApiWrapper.new.filter_products @user.loan_application
  end

  def new
    @user = User.new(loan_application: LoanApplication.new)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to edit_user_path @user
    else
      render :new, notice: "There was a problem saving your application"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to loan_path(@user.loan)
    else
      render :edit, notice: "There was a problem saving your application"
    end
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(
      :email,
      loan_application_attributes: [
        :id,
        :requested_amount,
        :property_state,
        :credit_score,
        :first_time_home_buyer
      ],
      loan_attributes: [
        :id,
        :name,
        :rate,
        :term
      ]
    )
  end
end
