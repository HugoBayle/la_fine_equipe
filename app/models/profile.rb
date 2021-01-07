class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :bio, presence: true
end
