class Event < ApplicationRecord
  # --- Associations ---
  belongs_to :venue
  has_many :bookings
  has_many :users, through: :bookings # musicians who booked
  has_one_attached :photo

  # --- Validations ---
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :date, presence: true
  validates :time, presence: true
  validates :max_slots, presence: true, numericality: { only_integer: true, greater_than: 0, message: "must be a positive whole number" }
  validates :venue_id, presence: true

  # --- Scopes ---
  scope :upcoming, -> { where('date >= ?', Date.current).order(:date, :time) }
  scope :past, -> { where('date < ?', Date.current).order(date: :desc, time: :desc) }


end
