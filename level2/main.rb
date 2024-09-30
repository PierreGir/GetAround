require_relative '../common/main'

module Level2
  def self.run_main
    data_path = File.join(__dir__, 'data')
    CommonMain.run_main(data_path, PriceStrategyLevel2)
  end
end

if __FILE__ == $PROGRAM_NAME
  Level2.run_main
end