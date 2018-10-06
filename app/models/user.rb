class User < ApplicationRecord
  validates :email, presence: true

  has_one :loan
  has_one :loan_application
end
