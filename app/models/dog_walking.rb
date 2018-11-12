class DogWalking < ApplicationRecord
  enum status: [:scheduled, :in_progress, :finished]
  validates :duration, inclusion: { in: [30,60], message: "%{value} is not a valid duration" }
  validates_numericality_of :pets, greater_than: 0
  
  validates :status, :latitude, :longitude, :pets, :duration, :schedule_date, presence: :true
  validate :check_status, on: :update
  before_save :calculate_price
  
  def calculate_price
    self.price = PriceCalculator.new(self).calculate
  end

  def start!
    self.update_attributes(status: :in_progress, start_date: Time.now )
  end

  def finish!
    self.update_attributes(status: :finished, end_date: Time.now )
  end
  
  def check_status
    errors.add(:status, "invalid change status '#{self.status_was}' to '#{self.status}'") unless allow_status_change?
  end

  def allow_status_change?
    (self.finished? && self.status_was == 'in_progress') || (self.in_progress? && self.status_was == 'scheduled')
  end
end