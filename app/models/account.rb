class Account < ActiveRecord::Base
  # hack to prevent Account from being accidentally instantiated!
  validates_presence_of :type
  
  belongs_to :currency
  
  has_many :entries, :class_name => "LedgerEntry"
  has_many :debits, :class_name => "DebitEntry"
  has_many :credits, :class_name => "CreditEntry"
end
