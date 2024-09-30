require 'date'
require_relative 'car'

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

  def duration
    (@end_date - @start_date).to_i + 1
  end

  private

  def parse_date(date_string)
    Date.parse(date_string)
  rescue Date::Error
    raise "Invalid date"
  end
end
