class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  enum status: { pending: "pending", accepted: "accepted", declined: "declined" }
end
