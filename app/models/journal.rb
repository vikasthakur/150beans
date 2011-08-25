class Journal
  include Mongoid::Document
  
  belongs_to :group
  has_many :transactions
  
  def top_tags_mtd(max=10)
    tags = top_tags(journal_transactions.mtd.where).take(max)
  end
  
  def top_tags_ytd(max=10)
    tags = top_tags(journal_transactions.ytd).take(max)
  end
  
  def top_tags_by_value_mtd(max=10)
    tags = top_tags_by_value(journal_transactions.mtd).take(max)
  end
  
  def top_tags_by_value_ytd(max=10)
    tags = top_tags_by_value(journal_transactions.ytd).take(max)
  end
  
  private
    def journal_transactions
      Transaction.where(journal_id:self.id)
    end
    
    def top_tags(criteria)
      sorted_tags = Array.new
      criteria.collect {|t| t.tags_array}.flatten.uniq.each do |tag|
        sorted_tags << [criteria.tagged_with(:tags, tag).size, tag]
      end
      
      return sorted_tags.sort.reverse
    end
    
    def top_tags_by_value(criteria)
      sorted_tags = Array.new
      criteria.collect {|t| t.tags_array}.flatten.uniq.each do |tag|
        total = 0
        criteria.tagged_with(:tags, tag).each { |t| total += t.amount}
        sorted_tags << [total, tag]
      end
      
      return sorted_tags.sort.reverse
    end
end
