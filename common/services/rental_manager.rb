require_relative 'validation_service'
require_relative '../models/commission'

class RentalManager
  def initialize
    @validation_service = ValidationService.new
  end

  def process_rental(rental, strategy)
    @validation_service.validate(rental)
    rental.price = strategy.compute_price(rental)
    rental.commission = Commission.new(rental, strategy)
    strategy.compute_actions(rental)
  end
end
