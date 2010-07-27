class Account < ActiveRecord::Base
  # hack to prevent Account from being accidentally instantiated!
  validates_presence_of :type
  
  belongs_to :currency
  
  has_many :entries, :class_name => "LedgerEntry"
  has_many :debits, :class_name => "DebitEntry"
  has_many :credits, :class_name => "CreditEntry"
  
  def debit_total
    debits.sum('amount')
  end
  def credit_total
    credits.sum('amount')
  end
  def debit_balance?
    debit_total > credit_total
  end
  def debit_balance
    if debit_balance?
      debit_total - credit_total
    else
      0
    end
  end
  def credit_balance?
    credit_total > debit_total
  end
  def credit_balance
    if credit_balance?
      credit_total - debit_total
    else
      0
    end
  end
  def zero_balance?
    credit_total == debit_total
  end
  def balance
    if zero_balance?
      0
    elsif debit_balance?
      debit_balance
    else # credit_balance?
      credit_balance
    end
  end
end
