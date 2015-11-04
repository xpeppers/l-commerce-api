module PriceHelper
  def format_price price
    number_to_currency(price, separator: ',', delimiter: '', unit: '€', format: '%n %u')
  end
end
