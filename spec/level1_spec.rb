require_relative '../level1/main'

RSpec.describe 'Level 1 functions' do
  let(:output_path) { 'level1/data/output.json' }
  let(:expected_output_path) { 'level1/data/expected_output.json' }

  after do
    # Cleanup output file after each test
    File.delete(output_path) if File.exist?(output_path)
  end

  it 'should complete level 1' do
    # Get expected output data
    expected_output = JSON.parse(File.read(expected_output_path))

    # Run main function
    Level1.run_main

    # Get output data
    output_data = JSON.parse(File.read(output_path))

    # Compare output with expected output
    expect(output_data).to eq(expected_output)
  end
end
