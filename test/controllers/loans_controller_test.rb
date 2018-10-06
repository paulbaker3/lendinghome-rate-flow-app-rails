require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :loans

  def setup
    @loan = loans(:one)
  end

  def test_should_get_show
    get loan_url @loan
    assert_response :success
  end
end
