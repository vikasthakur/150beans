module AccountsHelper
  def type_badge(account_type)
    account_type.to_s.split(/Account/)
  end
  def humanize_debit_balance(account)
    if account.debit_balance?
      "#{number_to_currency(account.balance.abs, :unit => "")} DR"
    else
      ""
    end
  end
  def humanize_credit_balance(account)
    if account.credit_balance?
      "#{number_to_currency(account.balance.abs, :unit => "")} CR"
    else
      ""
    end
  end
  def humanize_debit_total(total)
    if total > 0
      "#{humanize_amount(total)} DR"
    else
      ""
    end
  end
  def humanize_credit_total(total)
    if total > 0
      "#{humanize_amount(total)} CR"
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
