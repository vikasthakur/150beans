class Account < ActiveRecord::Base
  # hack to prevent Account from being accidentally instantiated!
  validates_presence_of :type
  
  has_many :ledger_entries
end
