module AccountsHelper
  def type_badge(account_type)
    account_type.to_s.split(/Account/)
  end
  def humanize_account_balance(account)
    balance = number_to_currency(account.balance, :unit => "")
    if account.zero_balance?
      "-.-"
    elsif account.debit_balance?
      "#{balance} DR"
    else
      "#{balance} CR"
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
