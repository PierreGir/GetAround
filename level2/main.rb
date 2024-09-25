require_relative '../common/models/car'
require_relative '../common/models/rental'
require_relative '../common/data_serializer'
require_relative '../common/price_strategy'

module Level2
    def self.run_main
        # Initiate file paths
        input_file_path = File.join(__dir__, 'data', 'input.json')
        output_file_path = File.join(__dir__, 'data', 'output.json')

        # Read input data
        input_data = read_json_from_file(input_file_path)
        cars, rentals = deserialize(input_data)

        # Compute the price for each rental
        price_strategy_level_2 = PriceStrategyLevel2.new
        rentals.each do |rental|
            rental.compute_price(price_strategy_level_2)
        end

        # Write output data
        output_data = serialize(rentals)
        write_json_into_file(output_data, output_file_path)
    end
end

if __FILE__ == $PROGRAM_NAME
    Level2.run_main
end