MoneyRails.configure do |config|
  config.default_currency = :twd
  config.rounding_mode = BigDecimal::ROUND_HALF_UP
end