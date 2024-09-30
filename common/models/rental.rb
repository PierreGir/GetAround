require 'date'
require_relative 'car'
require_relative 'commission'

class Rental
  attr_accessor :price, :commission, :duration, :actions, :options
  attr_reader :id, :car, :start_date, :end_date, :distance

  def initialize(id, car, start_date, end_date, distance)
    @id = id
    @car = car
    @start_date = parse_date(start_date)
    @end_date = parse_date(end_date)
    @distance = distance
    @price = 0
    @actions = []
    @options = []
  end

  def compute_price(strategy)
    validate_inputs
    @price = strategy.compute_price(self)
    @commission = Commission.new(self, strategy)
  end

  def compute_actions(strategy)
    strategy.compute_actions(self)
  end

  def duration
    (@end_date - @start_date).to_i + 1
  end

  private
  def parse_date(date_string)
    Date.parse(date_string)
  rescue Date::Error
    raise "Invalid date"
  end

  def validate_inputs
    raise "End date cannot be before start date" if @end_date < @start_date
    raise "Distance cannot be negative" if @distance < 0
    raise "Price per day cannot be nil" if @car.price_per_day.nil?
    raise "Price per km cannot be nil" if @car.price_per_km.nil?
  end
end
