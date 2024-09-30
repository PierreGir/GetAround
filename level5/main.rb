require_relative '../common/main'

module Level5
  def self.run_main
    data_path = File.join(__dir__, 'data')
    CommonMain.run_main(data_path, PriceStrategyLevel5, witg_options = true)
  end
end

if __FILE__ == $PROGRAM_NAME
  Level5.run_main
end