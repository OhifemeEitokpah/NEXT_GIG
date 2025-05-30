class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# Include additional modules as needed
  has_many :venues
  has_many :bookings
  has_many :events, through: :bookings
  has_many :booked_events, through: :venues, source: :events
  has_many :booked_bookings, through: :booked_events, source: :bookings
  has_many :notifications, dependent: :destroy
  enum role: { musician: 0, organiser: 1 }
end
