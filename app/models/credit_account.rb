class CreditAccount < Account
  def balance_in_period(from,to)
    credit_total_in_period(from,to) - debit_total_in_period(from,to)
  end
  def credit_balance?
    balance >= 0
  end
  def debit_balance?
    !credit_balance?
  end
end