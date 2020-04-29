class User < ApplicationRecord
  has_many :meals, :bookings, :reviews
end
