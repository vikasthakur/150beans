# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100726091859) do

  create_table "accounts", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "group"
    t.integer  "currency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "decimals"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ledger_entries", :force => true do |t|
    t.string   "type"
    t.date     "date"
    t.decimal  "amount",     :precision => 19, :scale => 4, :default => 0.0
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.date     "date",                                                              :null => false
    t.decimal  "amount",          :precision => 19, :scale => 4, :default => 0.0,   :null => false
    t.string   "notes"
    t.boolean  "is_voided",                                      :default => false
    t.integer  "debit_entry_id",                                                    :null => false
    t.integer  "credit_entry_id",                                                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
