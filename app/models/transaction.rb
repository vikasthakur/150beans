class Transaction < ActiveRecord::Base
  belongs_to :debit_account, :class_name => "Account", :foreign_key => "debit_account_id"
  belongs_to :credit_account, :class_name => "Account", :foreign_key => "credit_account_id"
  has_one :debit, :class_name => "DebitEntry"
  has_one :credit, :class_name => "CreditEntry"
end
