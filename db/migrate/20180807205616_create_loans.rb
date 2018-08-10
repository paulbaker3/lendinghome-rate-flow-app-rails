class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.decimal :rate
      t.integer :term
      t.references :user

      t.timestamps
    end
  end
end
