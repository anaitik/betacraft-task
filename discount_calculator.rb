class DiscountCalculator
  # Pricing table with item details
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
    # Get user input for purchased items
    user_input = InputHandler.new.get_user_input
    user_input.each { |item| @items[item.capitalize] += 1 }
    
    # Calculate total price and display receipt
    calculate_total_price
    OutputHandler.new.display_receipt(@items, @total_price, calculate_total_saved, PRICING_TABLE)
  end

  private

  def calculate_total_price
    @total_price = 0.0

    # Iterate through each item in the pricing table
    PRICING_TABLE.each do |item, details|
      quantity = @items[item]
      if details.key?(:sale_quantity) && quantity >= details[:sale_quantity]
        calculate_sale_price_and_remaining_items(item, quantity, details)
      else
        @total_price += calculate_regular_price(quantity, details)
      end
    end
  end

  def calculate_sale_price_and_remaining_items(item, quantity, details)
    # Calculate price for items on sale and remaining items
    sale_price_items = (quantity / details[:sale_quantity]) * details[:sale_price]
    remaining_items = (quantity % details[:sale_quantity]) * details[:unit_price]
    @total_price += sale_price_items + remaining_items
  end

  def calculate_regular_price(quantity, details)
    # Calculate regular price for items not on sale
    quantity * details[:unit_price]
  end

  def calculate_total_saved
    total_regular_price = 0.0

    # Calculate total regular price for all items
    PRICING_TABLE.each do |item, details|
      total_regular_price += @items[item] * details[:unit_price]
    end

    # Calculate total savings
    total_regular_price - @total_price
  end
end

class InputHandler
  def get_user_input
    puts 'Please enter all the items purchased separated by a comma:'
    gets.chomp.downcase.split(',').map(&:strip)
  end
end

class OutputHandler
  def display_receipt(items, total_price, total_saved, pricing_table)
    puts "\nItem\tQuantity\tPrice\n--------------------------------------"

    # Display receipt for each item
    pricing_table.each do |item, details|
      quantity = items[item]
      puts "#{item}\t#{quantity}\t\t$#{'%.2f' % (quantity * details[:unit_price])}" unless quantity.zero?
    end
    puts "\nTotal price: $#{'%.2f' % total_price}"
    puts "You saved $#{'%.2f' % total_saved} today."
  end
end

# Command to run the script
DiscountCalculator.new.run
