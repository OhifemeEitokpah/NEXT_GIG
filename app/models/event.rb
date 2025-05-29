# app/models/event.rb

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
  validate :date_cannot_be_in_the_past

  # --- Scopes ---
  scope :upcoming, -> { where('date >= ?', Date.current).order(:date, :time) }
  scope :past, -> { where('date < ?', Date.current).order(date: :desc, time: :desc) }

  def date_cannot_be_in_the_past
    if date.present? && date < Date.current
      errors.add(:date, "can't be in the past")
    end
  end

  # Finds a booking for the current visitor (now only for logged-in users).
  # The session_bookings_hash parameter is no longer used for logic here.
  def booking_for_current_visitor(current_user_obj, _session_bookings_hash = nil) # _session_bookings_hash is ignored
    # Only look for a booking if a user is logged in
    if current_user_obj.present?
      booking = bookings.find_by(user: current_user_obj, status: [:pending, :confirmed])
      return booking if booking.present?
    end
    nil # If no user is logged in or no booking found, return nil
  end
end
