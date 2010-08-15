class Account < ActiveRecord::Base
  # hack to prevent Account from being accidentally instantiated!
  validates_presence_of :type
  
  belongs_to :currency
  
  has_many :entries, :class_name => "LedgerEntry", :order => "date"
  has_many :debits, :class_name => "DebitEntry", :order => "date"
  has_many :credits, :class_name => "CreditEntry", :order => "date"
  
  def debit_total_in_period(from, to)
    debits.between(from,to).sum('amount')
  end
  def credit_total_in_period(from, to)
    credits.between(from, to).sum('amount')
  end
  def balance_in_period(from, to)
    raise NotImplementedError.new("You must implement balance_in_period(from, to).")
  end
  
  def balance_to_date(date)
    balance_in_period(Date.civil, date)
  end
  def balance_mtd
    balance_in_period(Date.today.beginning_of_month, Date.today)
  end
  def balance_ytd
    balance_in_period(Date.today.beginning_of_year, Date.today)
  end
  def balance # current balance
    balance_to_date(Date.today)
  end

  def debit_balance?
    raise NotImplementedError.new("You must implement debit_balance?.")    
  end
  def credit_balance?
    raise NotImplementedError.new("You must implement credit_balance?.")    
  end    
end
