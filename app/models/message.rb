class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :to_user_id, presence: true
  validates :message, presence: true
  validates :status, presence: true
end
