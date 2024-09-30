require_relative '../common/main'

module Level1
  def self.run_main
    data_path = File.join(__dir__, 'data')
    CommonMain.run_main(data_path, PriceStrategyLevel1)
  end
end

if __FILE__ == $PROGRAM_NAME
  Level1.run_main
end