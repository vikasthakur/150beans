# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
currencies = Currency.create([
  {:code => 'CNY', :name => 'Chinese Yuan Renminbi', :decimals => 2, :symbol => '¥'},
  {:code => 'USD', :name => 'US Dollar', :decimals => 2, :symbol => '$'},
  {:code => 'HKD', :name => 'Hong Kong Dollar', :decimals => 2, :symbol => '$'},
  {:code => 'CAD', :name => 'Canadian Dollar', :decimals => 2, :symbol => '$'},
  {:code => 'GBP', :name => 'Pound Sterling', :decimals => 2, :symbol => '£'},
  {:code => 'EUR', :name => 'Euro', :decimals => 2, :symbol => '€'},
  {:code => 'CHF', :name => 'Swiss Franc', :decimals => 2, :symbol => 'CHF'},
  {:code => 'JPY', :name => 'Japanese Yen', :decimals => 0, :symbol => '¥'}
])