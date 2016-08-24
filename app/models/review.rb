class Review < ApplicationRecord

  belongs_to :user
  belongs_to :restaurant
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
  validates :rating, inclusion: (1..5)

end
