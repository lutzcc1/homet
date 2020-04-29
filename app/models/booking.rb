class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  validates :date, :eaters, presence: true
end
