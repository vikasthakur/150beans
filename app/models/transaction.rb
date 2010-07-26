class Transaction < ActiveRecord::Base
  has_one :debit, :class_name => "DebitEntry"
  has_one :credit, :class_name => "CreditEntry"
end
