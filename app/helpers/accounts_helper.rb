module AccountsHelper
  def type_badge(account_type)
    account_type.to_s.split(/Account/)
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
