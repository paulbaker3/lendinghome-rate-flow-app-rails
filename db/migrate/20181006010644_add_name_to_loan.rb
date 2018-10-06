class AddNameToLoan < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :name, :string
  end
end
