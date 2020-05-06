class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :booking
  validates :name, :address, :description, :price, :min_eaters, :max_eaters, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # name uniquenes commented to allow db:seed to create mock records
  # validates :name, uniqueness: true
end
