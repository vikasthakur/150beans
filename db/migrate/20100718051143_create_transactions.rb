class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.date        :date
      t.decimal     :amount,        :default => 0.0,  :precision => 19, :scale => 4
      t.string      :notes
      t.integer     :currency_id,   :default => nil
      t.float       :exchange_rate, :default => 0.0
      t.integer     :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
