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
    if self.position == 1
      Request.where(status: "confirmed").update_all("position = position - 1")
    else
      Request.where("#{self.position} < position").update_all("position = position - 1")
    end
    self.position = nil
    self.save
    UserMailer.welcome(self.user).deliver_now
  end

  def move_to_position(new_position)
    requests_positions = Request.where("position > 0").order("position ASC").map { |request| request.position }
    last_position = requests_positions.last
    # if new position < 1
    if new_position < 1
      puts "Please enter a position > 0"
    # if new position 1
    elsif new_position == 1
      requests_go_up = Request.confirmed.where("position < #{self.position}")
      requests_go_up.each do |request|
        request.position = request.position + 1
        request.save
      end
      self.position = new_position
      self.save
    # if new position don't exist
    elsif new_position > last_position
      requests_go_down = Request.confirmed.where("position > #{self.position}")
      requests_go_down.each do |request|
        request.position = request.position - 1
        request.save
      end
      self.position = last_position
      self.save
      p "The request has been moved to position #{self.position}, because it was the next one available."
    # if new position > old position
    elsif new_position > self.position
      request_go_down = Request.confirmed.where("position > #{self.position} and position <= #{new_position}")
      request_go_down.each do |request|
        request.position = request.position - 1
        request.save
      end
      self.position = new_position
      self.save
    #if new position < old position
    else new_position < self.position
      request_go_up = Request.confirmed.where("position >= #{new_position} and position < #{self.position}")
      request_go_up.each do |request|
        request.position = request.position + 1
        request.save
      end
      self.position = new_position
      self.save
    end
  end
end
