class DebitAccount < Account
  def balance_in_period(from,to)
    debit_total_in_period(from,to) - credit_total_in_period(from,to)
  end
  def debit_balance?
    balance >= 0
  end
  def credit_balance?
    !debit_balance?
  end
end