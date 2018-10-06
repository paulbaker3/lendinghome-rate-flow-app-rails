require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  setup do
    @user = users(:one)
  end


  def test_should_get_new
    get new_user_url
    assert_response :success
  end

  def test_should_create_user_and_associated_loan_application
    assert_difference ["User.count", "LoanApplication.count"] do
      post users_url,
          params: {
            user: {
              email: @user.email,
              loan_application_attributes: {
                requested_amount:      400_000,
                property_state:        "CA",
                credit_score:          800,
                first_time_home_buyer: false,
              }
            }
          }
    end

    assert_redirected_to edit_user_url(User.last)
  end

  def test_should_get_edit
    get edit_user_url @user
    assert_response :success
  end

  def test_should_update_user_with_selected_loan
    patch user_url(@user),
          params: {
            user: {
              email: @user.email,
              loan_attributes: {
                id: @user.loan.id,
                name: "Some Good Loan",
                rate: 1.0,
                term: 360,
              }
            }
          }

    assert_redirected_to loan_url(@user.loan)
  end
end
