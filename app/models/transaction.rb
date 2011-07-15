class Transaction
  include Mongoid::Document
  field :date, type: Date, default: -> { Date.today }
  field :amount, type: BigDecimal
  field :notes, type: String
  
  belongs_to :journal
  
  validates_presence_of :amount
end
