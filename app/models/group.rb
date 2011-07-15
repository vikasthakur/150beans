class Group
  include Mongoid::Document
  field :name, :type => String
  
  has_and_belongs_to_many :users
  has_one :journal
  
  validates_presence_of :name
  
  after_create :create_journal
  
  private
    def create_journal
      self.journal = Journal.create!
    end
end
