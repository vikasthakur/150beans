class Account < ActiveRecord::Base
  has_many :transaction
end
