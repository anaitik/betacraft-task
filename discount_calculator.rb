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
    calculate_total_price
    display_receipt
  end
  private
  
    def calculate_total_price
      @total_price = 0.0
    
      PRICING_TABLE.each do |item, details|
        quantity = @items[item]
        if details.key?(:sale_quantity) && quantity >= details[:sale_quantity]
          sale_price_items = (quantity / details[:sale_quantity]) * details[:sale_price]
          remaining_items = (quantity % details[:sale_quantity]) * details[:unit_price]
          @total_price += sale_price_items + remaining_items
        else
          @total_price += quantity * details[:unit_price]
        end
      end
    end
    
    def display_receipt
      puts "\nItem\tQuantity\tPrice\n--------------------------------------"
    
      PRICING_TABLE.each do |item, details|
        quantity = @items[item]
        puts "#{item}\t#{quantity}\t\t$#{'%.2f' % (quantity * details[:unit_price])}" unless quantity.zero?
      end
      puts "\nTotal price: $#{'%.2f' % @total_price}"
    end
end

DiscountCalculator.new.run
