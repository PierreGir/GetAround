require 'json'
require_relative 'models/car'
require_relative 'models/rental'

def read_json_from_file(input_path)
  raise "File not found: #{input_path}" unless File.exist?(input_path)
  begin
    JSON.parse(File.read(input_path))
  rescue JSON::ParserError => e
    raise "Invalid JSON format: #{e.message}"
  end
end

def write_json_into_file(data, output_path)
  begin
    json_data = JSON.pretty_generate(data)
  rescue JSON::GeneratorError => e
    raise "Invalid JSON data: #{e.message}"
  end
  File.write(output_path, json_data)
end

def deserialize(data)
  cars = data['cars'].map do |car_data|
    Car.new(car_data['id'], car_data['price_per_day'], car_data['price_per_km'])
  end

  rentals = data['rentals'].map do |rental_data|
    car = cars.find { |c| c.id == rental_data['car_id'] }
    raise "Car not found for rental #{rental_data['id']}" if car.nil?
    Rental.new(rental_data['id'], car, rental_data['start_date'], rental_data['end_date'], rental_data['distance'])
  end
  
  return cars, rentals
end

def serialize(rentals)
  {
    rentals: rentals.map do |rental|
      rental_data = { id: rental.id }

      if rental.actions && !rental.actions.empty?
        # action serialization
        rental_data["actions"] = rental.actions.map do |action|
          {
            who: action["who"],
            type: action["type"],
            amount: action["amount"]
          }
        end
      else
        # price and commission serialization
        rental_data["price"] = rental.price
        if rental.commission && rental.commission.insurance_fee
          rental_data["commission"] = {
            insurance_fee: rental.commission.insurance_fee,
            assistance_fee: rental.commission.assistance_fee,
            getaround_fee: rental.commission.getaround_fee
          }
        end
      end

      rental_data
    end
  }
end
