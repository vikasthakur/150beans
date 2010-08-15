class Transaction < ActiveRecord::Base
  belongs_to :debit_account, :class_name => "Account", :foreign_key => "debit_account_id"
  belongs_to :credit_account, :class_name => "Account", :foreign_key => "credit_account_id"
  has_one :debit, :class_name => "DebitEntry", :dependent => :destroy
  has_one :credit, :class_name => "CreditEntry", :dependent => :destroy
  
  default_scope :order => "date"
  
  named_scope :ending, lambda { |to| { :conditions => ["date <= ?", to] } }
  named_scope :starting, lambda { |date| { :conditions => ["date >= ?", from] } }
  named_scope :between, lambda { |from, to| { :conditions => ["date BETWEEN ? AND ?", from, to] } }
  
  named_scope :mtd, lambda { { :conditions => ["date BETWEEN ? AND ?", Date.today.beginning_of_month, Date.today] } }
  named_scope :ytd, lambda { { :conditions => ["date BETWEEN ? AND ?", Date.today.beginning_of_year, Date.today] } }
end
