require_relative '../common/models/car'
require_relative '../common/models/rental'
require_relative '../common/price_strategy'
require_relative '../common/data_serializer'
require_relative '../common/services/validation_service'

RSpec.describe 'Common functions' do
  let(:nonexistent_path) { 'nonexistent_input.json' }
  let(:invalid_json_input_path) { 'spec/data/errors/invalid_json_input.json' }
  let(:incomplete_data_input_path) { 'spec/data/errors/incomplete_data_input.json' }
  let(:price_strategy) { PriceStrategyLevel1.new }
  let(:validation_service) { ValidationService.new }

  describe 'read_json_from_file' do
    it 'raises an error when the input file does not exist' do
      expect { read_json_from_file(nonexistent_path) }
        .to raise_error(RuntimeError, /File not found/)
    end

    it 'raises an error for invalid JSON format' do
      expect { read_json_from_file(invalid_json_input_path) }
        .to raise_error(RuntimeError, /Invalid JSON format/)
    end
  end

  describe 'deserialize' do
    it 'raises an error when a car is not found for a rental' do
      invalid_data = read_json_from_file(incomplete_data_input_path)
      expect { deserialize(invalid_data) }
        .to raise_error(RuntimeError, /Car not found for rental/)
    end
  end

  describe 'compute_price' do
    let(:car) { Car.new(1, 2000, 10) }

    it 'raises an error for an invalid date format' do
      expect { Rental.new(5, car, 'invalid-date', '2024-09-25', 100) }
        .to raise_error(RuntimeError, /Invalid date/)
    end

    it 'raises an error when the end date is before the start date' do
      rental = Rental.new(1, car, '2024-09-25', '2024-09-20', 100)
      expect { validation_service.validate(rental) }
        .to raise_error(RuntimeError, /End date cannot be before start date/)
    end

    it 'raises an error when the distance is negative' do
      rental = Rental.new(2, car, '2024-09-20', '2024-09-25', -50)
      expect { validation_service.validate(rental) }
        .to raise_error(RuntimeError, /Distance cannot be negative/)
    end

    it 'raises an error when the price per day is nil' do
      car_with_nil_price_per_day = Car.new(3, nil, 10)
      rental = Rental.new(3, car_with_nil_price_per_day, '2024-09-20', '2024-09-25', 100)
      expect { validation_service.validate(rental) }
        .to raise_error(RuntimeError, /Price per day cannot be nil/)
    end

    it 'raises an error when the price per km is nil' do
      car_with_nil_price_per_km = Car.new(4, 2000, nil)
      rental = Rental.new(4, car_with_nil_price_per_km, '2024-09-20', '2024-09-25', 100)
      expect { validation_service.validate(rental) }
        .to raise_error(RuntimeError, /Price per km cannot be nil/)
    end
  end
end
