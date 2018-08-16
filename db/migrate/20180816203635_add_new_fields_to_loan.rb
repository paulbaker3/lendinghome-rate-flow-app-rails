class AddNewFieldsToLoan < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :amount, :float
    add_column :loans, :state, :string
    add_column :loans, :credit_score, :integer
    add_column :loans, :first_time_buyer, :boolean, default: false
  end
end
