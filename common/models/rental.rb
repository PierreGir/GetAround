require 'date'
require_relative 'car'

class Rental
  attr_accessor :price
  attr_reader :id, :car, :start_date, :end_date, :distance

  def initialize(id, car, start_date, end_date, distance)
    @id = id
    @car = car
    @start_date = parse_date(start_date)
    @end_date = parse_date(end_date)
    @distance = distance
    @price = 0
  end

  def compute_price
    raise "End date cannot be before start date" if @end_date < @start_date
    raise "Distance cannot be negative" if @distance < 0
    raise "Price per day cannot be nil" if @car.price_per_day.nil?
    raise "Price per km cannot be nil" if @car.price_per_km.nil?
  
    rental_days = (@end_date - @start_date).to_i + 1
    time_component = rental_days * @car.price_per_day
    distance_component = @distance * @car.price_per_km
    @price = time_component + distance_component
  end

  private
  def parse_date(date_string)
    Date.parse(date_string)
  rescue Date::Error
    raise "Invalid date"
  end
end
