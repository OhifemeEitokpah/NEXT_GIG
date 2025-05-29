# app/models/booking.rb
class Booking < ApplicationRecord
  # user_id is now REQUIRED, so remove optional: true
  belongs_to :user
  belongs_to :event

  # Define enum for status
  enum status: { pending: 0, confirmed: 1, cancelled: 2 }

  # Add explicit presence validation for user_id
  validates :user_id, presence: true
  validates :number_of_tickets, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :booking_date, presence: true
  validates :status, presence: true

  # Custom validation for available slots
  validate :event_has_available_slots

  private

  def event_has_available_slots
    if event.present? && number_of_tickets.present? && number_of_tickets > event.available_slots
      errors.add(:number_of_tickets, "Not enough slots available for this event")
    end
  end
end
