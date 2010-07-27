class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.date    :date,          :null => false
      t.decimal :amount,        :null => false, :default => 0.0,  :precision => 19, :scale => 4
      t.string  :notes
      t.boolean :is_voided,         :null => false, :default => false
      t.integer :debit_account_id,  :null => false
      t.integer :credit_account_id, :null => false
      t.integer :debit_entry_id,    :null => false, :default => 0
      t.integer :credit_entry_id,   :null => false, :default => 0
      
      t.timestamps
    end
    
    add_column :ledger_entries, :transaction_id, :integer
  end

  def self.down
    drop_table :transactions
    
    remove_column :ledger_entries, :transaction_id
  end
end
