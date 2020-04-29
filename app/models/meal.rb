class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings, :reviews, dependent: :destroy
  has_many :users, through: :booking
  validates :name, :address, :description, :price, :min_eaters, :max_eaters, presence: true
  validates :name, uniqueness: true
end
