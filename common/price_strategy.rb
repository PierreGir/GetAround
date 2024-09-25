class PriceStrategy
    def compute_price(rental)
        raise NotImplementedError, 'You must implement the compute_price method'
    end

    def compute_commission_details(rental)
        # Do nothing by default
    end
end

class PriceStrategyLevel1 < PriceStrategy
    def compute_price(rental)
      time_component = rental.duration * rental.car.price_per_day
      distance_component = rental.distance * rental.car.price_per_km
      (time_component + distance_component).to_i
    end
end

class PriceStrategyLevel2 < PriceStrategy
    def compute_price(rental)
        time_component = (1..rental.duration).sum { |day| rental.car.price_per_day * apply_discount(day) }
        distance_component = rental.distance * rental.car.price_per_km
        (time_component + distance_component).to_i
    end

    private

    def apply_discount(day)
        case day
        when 1 then 1.0
        when 2..4 then 0.9
        when 5..10 then 0.7
        else 0.5
        end
    end
end

class PriceStrategyLevel3 < PriceStrategyLevel2
    def compute_commission_details(commission)
        rental = commission.rental
        total_commission = (rental.price * 0.3).to_i
        commission.insurance_fee = (total_commission * 0.5).to_i
        commission.assistance_fee = [ (rental.duration * 100).to_i, total_commission- commission.insurance_fee ].min
        commission.getaround_fee = (total_commission - commission.insurance_fee - commission.assistance_fee).to_i
    end
end
  