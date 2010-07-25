module AccountsHelper
  def symbolled_amount(account, amount)
    "#{account.currency.symbol} #{amount}"
  end
end
