class Account < ActiveRecord::Base
  has_many :transactions
  belongs_to :currency
  belongs_to :account_type
end
