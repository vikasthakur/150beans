class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.date    :date,          :null => false
      t.decimal :amount,        :null => false, :default => 0.0,  :precision => 19, :scale => 4
      t.string  :notes
      t.boolean :is_voided,     :default => false
      t.integer :debit_entry_id   :null => false
      t.integer :credit_entry_id  :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
