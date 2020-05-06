class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  validates :date, :eaters, presence: true
  attr_accessor :time # so we can manage open hours on bookings form
end
