require_relative '../common/main'

module Level4
  def self.run_main
    data_path = File.join(__dir__, 'data')
    CommonMain.run_main(data_path, PriceStrategyLevel4)
  end
end

if __FILE__ == $PROGRAM_NAME
  Level4.run_main
end