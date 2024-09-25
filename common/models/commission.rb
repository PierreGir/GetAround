class Commission
    attr_accessor :rental, :insurance_fee, :assistance_fee, :getaround_fee
  
    def initialize(rental,strategy)
        @rental = rental
        @insurance_fee = nil
        @assistance_fee = nil
        @getaround_fee = nil
        strategy.compute_commission_details(self)
    end
end
  