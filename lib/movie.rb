class Movie < ActiveRecord::Base
  has_many :receipts
  has_many :users, through: :receipts
  has_many :reviews
end