module AccountsHelper
  def type_badge(account_type)
    account_type.to_s.split(/Account/)
  end
  def humanize_debit_balance(account)
    balance = number_to_currency(account.debit_balance, :unit => "")
    if account.debit_balance?
      "#{balance} DR"
    else
      ""
    end
  end
  def humanize_credit_balance(account)
    balance = number_to_currency(account.credit_balance, :unit => "")
    if account.credit_balance?
      "#{balance} CR"
    else
      ""
    end
  end
  def humanize_amount(amount)
    if amount == 0
      "-.--"
    else
      number_to_currency(amount, :unit => "")
    end
  end  
  def account_types_array
    [['Cash','AssetAccount'],
     ['Bank Account','AssetAccount'],
     ['Reimbursed Expenses','ReceivablesAccount'],
     ['Payables / Short Term Credit','LiabilityAccount'],
     ['Credit Card','LiabilityAccount'],
     ['TaoBao Account','LiabilityAccount'],
     ['Income','IncomeAccount'],
     ['Expenses','ExpenseAccount'],
     ['Equity','EquityAccount']]
  end
end
