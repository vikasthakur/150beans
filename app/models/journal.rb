class Journal
  include Mongoid::Document
  
  belongs_to :group
  has_many :transactions
  
  def total_mtd
    return total_amount(journal_transactions.mtd)
  end
  
  def total_ytd
    return total_amount(journal_transactions.ytd)
  end
  
  def top_tags_mtd(max=10)
    return top_tags(journal_transactions.mtd.where).take(max)
  end
  
  def top_tags_ytd(max=10)
    return top_tags(journal_transactions.ytd).take(max)
  end
  
  def top_tags_by_value_mtd(max=10)
    return top_tags_by_value(journal_transactions.mtd).take(max)
  end
  
  def top_tags_by_value_ytd(max=10)
    return top_tags_by_value(journal_transactions.ytd).take(max)
  end
  
  private
    def journal_transactions
      Transaction.where(journal_id:self.id)
    end
    
    def total_amount(transactions)
      total = 0
      transactions.each { |t| total += t.amount}
      return total
    end
    
    def top_tags(transactions)
      sorted_tags = Array.new
      transactions.collect {|t| t.tags_array}.flatten.uniq.each do |tag|
        sorted_tags << [transactions.tagged_with(:tags, tag).size, tag]
      end
      
      return sorted_tags.sort.reverse
    end
    
    def top_tags_by_value(transactions)
      sorted_tags = Array.new
      transactions.collect {|t| t.tags_array}.flatten.uniq.each do |tag|
        total = 0
        transactions.tagged_with(:tags, tag).each { |t| total += t.amount}
        sorted_tags << [total, tag]
      end
      
      return sorted_tags.sort.reverse
    end
end
