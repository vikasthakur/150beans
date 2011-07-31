# encoding: utf-8

class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date
  field :amount, type: BigDecimal
  field :currency, type: String
  field :notes, type: String
  
  scope :for_journal, ->(journal) { where(journal_id: journal.id) }
  scope :rev_chrono, order_by([[:date, :desc], [:created_at, :desc]])
  scope :chrono, order_by([[:date, :asc], [:created_at, :asc]])
  
  belongs_to :journal
  
  validates_presence_of :date, :amount, :currency, :notes
  
  before_validation :parse_notes
  
  # description with dates and amount stripped
  def desc
    s = self.notes
    match = s.downcase.match(/\^\d{4}-\d{2}-\d{2}/)
    s.sub!(match.to_s, '').strip! if match
    match = s.upcase.match(/(RMB|CNY|USD|HKD|CAD|EUR|GBP)[ ]*\d+\.?\d*/)
    s.sub!(match.to_s, '').strip! if match
    s
  end

  private
    def parse_notes
      tags = self.notes.scan(/#[^ ]+/)
      
      match = self.notes.downcase.match(/\^(now|today|yesterday|yes|-\d+|[^ ]+)/)
      if match.nil? || %w[now today].include?(match[1])
        self.date = Date.today
      elsif %w[yesterday yes].include?(match[1])
        self.date = Date.yesterday
      elsif match[1].start_with?('-')
        self.date = Date.today - match[1].delete('-').to_i
      else
        # TODO deal with the various date formats
        # acceptable formats: y-m-d
        #   2011/7/8
        #   2011/07/08
        #   2011-7-8
        #   2011-07-08
        #   7/8 - defaults to current year
        #   7-8 - defaults to current year
        # 
        self.date = Date.parse(match[1]) 
      end
      
      # substitute date with known format
      strip_from_notes_anycase(match.to_s) unless match.nil?
      self.notes = self.notes.strip + " ^#{self.date.to_s}"
      
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
        
        # substitute amount with known format
        strip_from_notes_anycase(match.to_s) unless match.nil?
        self.notes = "#{self.currency} #{self.amount} " + self.notes.strip unless match.nil?
      end
    end
    
    def strip_from_notes_anycase(target)
      index = self.notes.upcase.index(target.upcase)
      self.notes.slice!(index, target.length)
    end
end
