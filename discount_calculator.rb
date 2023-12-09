class DiscountCalculator
  PRICING_TABLE = {
    'Milk' => { unit_price: 3.97, sale_quantity: 2, sale_price: 5.00 },
    'Bread' => { unit_price: 2.17, sale_quantity: 3, sale_price: 6.00 },
    'Banana' => { unit_price: 0.99 },
    'Apple' => { unit_price: 0.89 }
  }

  def initialize
    @items = Hash.new(0)
  end

  def run
    puts 'Please enter all the items purchased separated by a comma:'
    user_input = gets.chomp.downcase.split(',').map(&:strip)
  
    user_input.each { |item| @items[item.capitalize] += 1 }
  end

end
