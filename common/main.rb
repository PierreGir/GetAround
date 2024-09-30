require_relative 'models/car'
require_relative 'models/rental'
require_relative 'data_serializer'
require_relative 'price_strategy'
require_relative 'services/rental_manager'

module CommonMain
  def self.run_main(data_path, price_strategy_class, with_options = false)
    # Initiate file paths
    input_file_path = File.join(data_path, 'input.json')
    output_file_path = File.join(data_path, 'output.json')

    # Read input data
    input_data = read_json_from_file(input_file_path)
    cars, rentals = deserialize(input_data)

    # Compute the price for each rental
    price_strategy = price_strategy_class.new
    rental_manager = RentalManager.new
    rentals.each do |rental|
      rental_manager.process_rental(rental, price_strategy)
    end

    # Write output data
    output_data = serialize(rentals, with_options)
    write_json_into_file(output_data, output_file_path)
  end
end
