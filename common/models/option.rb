class Option
  attr_reader :id, :type

  OPTION_DETAILS = {
    "gps" => { price: 500, beneficiary: "owner" },
    "baby_seat" => { price: 200, beneficiary: "owner" },
    "additional_insurance" => { price: 1000, beneficiary: "getaround" }
  }

  def initialize(id, type)
    @id = id
    @type = type
  end

  def price_per_day
    OPTION_DETAILS.dig(type, :price) || 0
  end

  def beneficiary
    OPTION_DETAILS.dig(type, :beneficiary) || "unknown"
  end
end
