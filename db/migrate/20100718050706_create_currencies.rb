class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string      :code
      t.string      :name
      t.integer     :decimals
      t.string      :symbol

      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
