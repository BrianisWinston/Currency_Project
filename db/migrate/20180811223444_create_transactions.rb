class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :sender, null: false
      t.string :receiver, null: false
      t.float :amount, null: false

      t.timestamps
    end
  end
end
