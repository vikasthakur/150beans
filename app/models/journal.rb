class Journal
  include Mongoid::Document
  
  belongs_to :group
  has_many :transactions
end
