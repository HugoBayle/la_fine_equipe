class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :profile, dependent: :destroy
  has_one :request, dependent: :destroy

  after_create :generate_request
  before_update :set_position_to_request, if: :confirmed_at_changed?

  private

  def generate_request
    Request.create(user: self)
  end

  def set_position_to_request
    if Request.where("position > 0") != []
      self.request.position = last_known_position + 1
      self.request.status = "confirmed"
      self.request.last_check = Time.now
      self.request.save
    else
      self.request.position = 1
      self.request.status = "confirmed"
      self.request.last_check = Time.now
      self.request.save
    end
  end

  def last_known_position
    requests_positions = Request.where("position > 0").order("position ASC").map { |request| request.position }
    last_position = requests_positions.last
  end
end
