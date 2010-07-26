class CreateLedgerEntries < ActiveRecord::Migration
  def self.up
    create_table :ledger_entries do |t|
      t.string      :type
      t.date        :date
      t.decimal     :amount,        :default => 0.0,  :precision => 19, :scale => 4
      t.integer     :account_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ledger_entries
  end
end
