class Loan < ApplicationRecord
  RATE = 3.25.to_d
  TERM = 15 * 12 # 15 years in months

  belongs_to :user

  before_create :set_defaults

  def set_defaults
    self.rate = RATE
    self.term = TERM
  end
end
