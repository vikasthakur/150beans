class LedgerEntry < ActiveRecord::Base
  # hack to prevent LedgerEntry from being accidentally instantiated!
  validates_presence_of :type
end
