class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true  # e.g. the Booking

  scope :unread, -> { where(read_at: nil) }

  def mark_as_read!
    update!(read_at: Time.current)
  end
end
