class Request < ApplicationRecord
  STATUS = %w(unconfirmed confirmed accepted expired)
  belongs_to :user

  validates :status, inclusion: { in: STATUS }


  def self.unconfirmed
    Request.where(status: "unconfirmed")
  end

  def self.confirmed
    Request.where(status: "confirmed")
  end

  def self.accepted
    Request.where(status: "accepted")
  end

  def self.expired
    Request.where(status: "expired")
  end

  def accept!
    self.status = "accepted"
    self.position = nil
    self.save
    Request.where("position > 0").update_all("position = position - 1")
  end
end
