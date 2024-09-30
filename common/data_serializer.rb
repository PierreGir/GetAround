require 'json'
require_relative 'models/car'
require_relative 'models/rental'
require_relative 'models/option'

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

  # Deserialize cars
  cars = data['cars'].map do |car_data|
    Car.new(car_data['id'], car_data['price_per_day'], car_data['price_per_km'])
  end

  rentals = data['rentals'].map do |rental_data|
    car = cars.find { |c| c.id == rental_data['car_id'] }
    raise "Car not found for rental #{rental_data['id']}" if car.nil?
    
    # Deserialize rental
    rental = Rental.new(rental_data['id'], car, rental_data['start_date'], rental_data['end_date'], rental_data['distance'])

    # Deserialize options into rental if exists
    if data['options'] && !data['options'].empty?
      rental_options = data['options'].select { |rental_option| rental_option['rental_id'] == rental.id }
      rental_options.each do |rental_option|
        rental.options.push(Option.new(rental_option['id'], rental_option['type']))
      end
    end

    rental
  end
  
  return cars, rentals
end

def serialize(rentals, with_options = false)
  {
    rentals: rentals.map do |rental|
      rental_data = { id: rental.id }

      # Option Serialization
      if with_options
        if rental.options && !rental.options.empty?
          rental_data["options"] = rental.options.map(&:type)
        else
          rental_data["options"] = []
        end
      end

      if rental.actions && !rental.actions.empty?
        # Action serialization
        rental_data["actions"] = rental.actions.map do |action|
          {
            who: action["who"],
            type: action["type"],
            amount: action["amount"]
          }
        end
      else
        # Price and commission serialization
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
