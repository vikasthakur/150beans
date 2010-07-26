class CreateLedgerEntries < ActiveRecord::Migration
  def self.up
    create_table :ledger_entries do |t|
      t.date    date
      t.decial  amount
      t.integer account_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ledger_entries
  end
end
