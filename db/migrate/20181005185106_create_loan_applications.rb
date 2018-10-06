class CreateLoanApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_applications do |t|
      t.decimal :requested_amount
      t.string :property_state
      t.integer :credit_score
      t.boolean :first_time_home_buyer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
