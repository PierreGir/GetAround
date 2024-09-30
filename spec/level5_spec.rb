require_relative '../level5/main'

RSpec.describe 'Level 5 functions' do
  let(:output_path) { 'level5/data/output.json' }
  let(:expected_output_path) { 'level5/data/expected_output.json' }

  after do
    # Cleanup output file after each test
    File.delete(output_path) if File.exist?(output_path)
  end

  it 'should complete level 5' do
    # Get expected output data
    expected_output = JSON.parse(File.read(expected_output_path))

    # Run main function
    Level5.run_main

    # Get output data
    output_data = JSON.parse(File.read(output_path))

    # Compare output with expected output
    expect(output_data).to eq(expected_output)
  end
end
