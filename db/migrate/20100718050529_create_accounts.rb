class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string      :name
      t.integer     :account_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
