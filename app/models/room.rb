class Room < ApplicationRecord
  belongs_to :user
  has_many :messages

  validates :to_user_id, presence: true
  validates :last_message, presence: true
end
