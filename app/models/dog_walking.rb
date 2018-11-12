class DogWalking < ApplicationRecord
  enum status: [:scheduled, :in_progress, :finished]
  validates :duration, inclusion: { in: [30,60], message: "%{value} is not a valid duration" }
  validates :status, :latitude, :longitude, :pets, :duration, :price, :schedule_date, presence: :true
  
  before_validation :calculate_price
  
  def calculate_price
    self.price = PriceCalculator.new(self).calculate
  end

  def start
    self.update_attributes(status: :in_progress, start_date: Time.now )
  end

  def finish
    self.update_attributes(status: :finished, end_date: Time.now )
  end
end