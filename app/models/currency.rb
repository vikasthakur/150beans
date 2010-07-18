class Currency < ActiveRecord::Base
  def name_with_symbol
    "#{code} (#{symbol}) - #{name}"
  end
end
