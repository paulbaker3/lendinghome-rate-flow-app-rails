class User < ApplicationRecord
  validates :email, presence: true

  has_one :loan
  has_one :loan_application

  accepts_nested_attributes_for :loan,
                                :loan_application
end
