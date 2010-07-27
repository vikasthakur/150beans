module AccountsHelper
  def type_badge(account_type)
    account_type.to_s.split(/Account/)
  end
  
  def account_types_array
    [['Cash','AssetAccount'],
     ['Bank Account','AssetAccount'],
     ['Reimbursed Expenses','AssetAccount'],
     ['Credit Card','LiabilityAccount'],
     ['TaoBao Account','LiabilityAccount'],
     ['Income','IncomeAccount'],
     ['Expenses','ExpenseAccount'],
     ['Equity','EquityAccount']]
  end
end
