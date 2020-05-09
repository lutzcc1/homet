class Review < ApplicationRecord
  belongs_to :meal
  belongs_to :user
  validates :rating, presence: true, inclusion: [1, 2, 3, 4, 5]
end
