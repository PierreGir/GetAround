require_relative '../level3/main'

RSpec.describe 'Level 3 functions' do
  let(:output_path) { 'level3/data/output.json' }
  let(:expected_output_path) { 'level3/data/expected_output.json' }

  after do
    # Cleanup output file after each test
    File.delete(output_path) if File.exist?(output_path)
  end

  it 'should complete level 3' do
    # Get expected output data
    expected_output = JSON.parse(File.read(expected_output_path))

    # Run main function
    Level3.run_main

    # Get output data
    output_data = JSON.parse(File.read(output_path))

    # Compare output with expected output
    expect(output_data).to eq(expected_output)
  end

  it 'should complete level 3 with a case where roadside assistance fee is too high' do
    input_path = 'spec/data/level3/extra_input.json'
    expected_output_path = 'spec/data/level3/extra_expected_output.json'

    # Read input data
    input_data = read_json_from_file(input_path)
    cars, rentals = deserialize(input_data)

    # Compute the price for each rental
    price_strategy_level_3 = PriceStrategyLevel3.new
    rentals.each do |rental|
        rental.compute_price(price_strategy_level_3)
    end

    # Get output data
    output_data = serialize(rentals)

    # Get expected output data
    expected_output = JSON.parse(File.read(expected_output_path))

    # Compare output with expected output
    expect(JSON.parse(output_data.to_json)).to eq(expected_output)
  end
end
