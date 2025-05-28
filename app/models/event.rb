class Event < ApplicationRecord
  belongs_to :venue
  belongs_to :user # organiser
  has_many :bookings
  has_many :users, through: :bookings # musicians who booked
  has_one_attached :photo
end
