class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :phone_number, presence: true, numericality: true, length: { :minimum => 10, :maximum => 10 }
  validates :bio, presence: true
end
