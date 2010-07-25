class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :type
      t.string :name
      t.string :group
      t.integer :currency_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
