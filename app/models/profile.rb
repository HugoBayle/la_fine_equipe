class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :phone_number, presence: true, numericality: true, length: { is: 10 }
  validates :bio, presence: true
end
