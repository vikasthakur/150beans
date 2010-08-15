class LedgerEntry < ActiveRecord::Base
  # hack to prevent LedgerEntry from being accidentally instantiated!
  validates_presence_of :type
  
  belongs_to :account
  belongs_to :transaction
  
  default_scope :order => "date"
  
  named_scope :ending, lambda { |to| { :conditions => ["date <= ?", to] } }
  named_scope :starting, lambda { |from| { :conditions => ["date >= ?", from] } }
  named_scope :between, lambda { |from, to| { :conditions => ["date BETWEEN ? AND ?", from, to] } }
  
  named_scope :mtd, lambda { { :conditions => ["date BETWEEN ? AND ?", Date.today.beginning_of_month, Date.today] } }
  named_scope :ytd, lambda { { :conditions => ["date BETWEEN ? AND ?", Date.today.beginning_of_year, Date.today] } }
end
