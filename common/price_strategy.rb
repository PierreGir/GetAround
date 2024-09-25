class PriceStrategy
    def compute_price(rental)
        raise NotImplementedError, 'You must implement the compute_price method'
    end
end

class PriceStrategyLevel1 < PriceStrategy
    def compute_price(rental)
      rental_days = (rental.end_date - rental.start_date).to_i + 1
      time_component = rental_days * rental.car.price_per_day
      distance_component = rental.distance * rental.car.price_per_km
      (time_component + distance_component).to_i
    end
end

class PriceStrategyLevel2 < PriceStrategy
    def compute_price(rental)
        rental_days = (rental.end_date - rental.start_date).to_i + 1
        time_component = (1..rental_days).sum { |day| rental.car.price_per_day * apply_discount(day) }
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
  