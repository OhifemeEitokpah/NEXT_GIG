class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# Include additional modules as needed
  has_many :venues
  has_many :bookings
  has_many :events, through: :bookings
  enum role: { musician: 0, organiser: 1 }
end
