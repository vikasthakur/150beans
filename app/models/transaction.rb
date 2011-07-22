# encoding: utf-8

class Transaction
  include Mongoid::Document
  field :date, type: Date
  field :amount, type: BigDecimal
  field :currency, type: String
  field :notes, type: String
  
  belongs_to :journal
  
  validates_presence_of :date, :amount, :currency, :notes
  
  before_validation :parse_notes

  private
    def parse_notes
      tags = self.notes.scan(/#[^ ]+/)
      match = self.notes.downcase.match(/\^(now|today|yesterday|-\d+|[^ ]+)/)
      if match.nil? || match[1]=="now" || match[1]=="today"
        self.date = Date.today
      elsif match[1]=="yesterday"
        self.date = Date.yesterday
      elsif match[1].start_with?('-')
        self.date = Date.today - match[1].delete('-').to_i
      else
        # TODO deal with the various date formats
        self.date = Date.parse(match[1]) 
      end
      
      match = self.notes.match(/(\$|£|€|¥)[ ]*[^ ]+/)
      match = self.notes.upcase.match(/\d+\.?\d*[ ]+(RMB|CNY|USD|CAD|HKD|EUR|GBP)/) unless match
      match = self.notes.upcase.match(/(RMB|CNY|USD|HKD|CAD|EUR|GBP)[ ]*\d+\.?\d*/) unless match
      match = self.notes.match(/^\d+\.?\d*/) unless match
      if match
        s = match[0]
        s.delete!(match[1]) if match[1]
        self.amount = BigDecimal.new(s).truncate(2)
        case match[1]
        when "$" then c = "USD"
        when "£" then c = "GBP"
        when "€" then c = "EUR"
        when "¥" then c = "CNY"
        when "RMB" then c = "CNY"
        else
          if %w[CNY USD HKD CAD EUR GBP].include? match[1]
            c = match[1]
          else
            c = "CNY"
          end
        end
        self.currency = c
      end
    end
end
