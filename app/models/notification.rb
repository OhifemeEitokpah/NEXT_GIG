class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }

  # after_create_commit do
  #   # prepend the new notification into the list
  #   broadcast_prepend_to(
  #     user,
  #     target: "notifications_list",
  #     partial: "shared/notification_item",
  #     locals: { notification: self }
  #   )

  #   # update the badge count
  #   broadcast_replace_to(
  #     user,
  #     target: "notifications_count",
  #     partial: "shared/notification_count",
  #     locals: { count: user.notifications.unread.count }
  #   )
  # end
end
