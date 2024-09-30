class ValidationService
    def validate(rental)
      raise "End date cannot be before start date" if rental.end_date < rental.start_date
      raise "Distance cannot be negative" if rental.distance < 0
      raise "Price per day cannot be nil" if rental.car.price_per_day.nil?
      raise "Price per km cannot be nil" if rental.car.price_per_km.nil?
    end
  end
  