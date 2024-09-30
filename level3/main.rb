require_relative '../common/main'

module Level3
  def self.run_main
    data_path = File.join(__dir__, 'data')
    CommonMain.run_main(data_path, PriceStrategyLevel3)
  end
end

if __FILE__ == $PROGRAM_NAME
  Level3.run_main
end