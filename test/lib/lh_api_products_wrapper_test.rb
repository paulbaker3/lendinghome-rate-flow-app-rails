require "test_helper"

class LhProductsApiWrapperTest < ActiveSupport::TestCase
  attr_accessor :sut

  fixtures :loan_applications

  def setup
    self.sut = LhProductsApiWrapper.new
  end

  def test_it_gets_products
    actual = sut.get_products

    assert_kind_of  Array,  actual
    assert_operator 1, :<=, actual.count
  end

  def test_it_reports_success
    sut.get_products
    assert sut.successful_response?
  end

  def test_it_reports_failure
    sut.http.use_ssl = false
    sut.get_products
    refute sut.successful_response?
  end

  def test_it_returns_an_empty_array_of_products_regardless_of_failure
    sut.http.use_ssl = false
    actual = sut.get_products

    assert_kind_of Array, actual
    assert_equal   0,     actual.count
  end

  def test_it_filters_results_for_a_loan_application
    assert_operator 1, :<=, sut.filter_products(loan_applications(:one)).count
  end

  def test_it_sorts_rates_by_lowest_available
    actual = sut.filter_products(loan_applications(:one))
    assert_operator actual.first["rate"], :<, actual.last["rate"]
  end
end
