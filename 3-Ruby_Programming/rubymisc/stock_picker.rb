def stock_picker(price_list)
	max_profit, buy_date, sell_date, eval_day = (-1.0/0), 0, 0, 0
		price_list[0..-2].each_with_index do |buy, i|
			price_list[(i+1)..-1].each_with_index do |sell, j|
				if (sell-buy) > max_profit
					buy_date = buy
					sell_date = sell
					max_profit = sell - buy
				end
			end
		end
		puts "Buy at #{buy_date} and sell at #{sell_date}, for a profit of #{max_profit}"


end

stock_picker([17,3,6,9,15,8,6,1,10])
#price_list = Array.new
#puts "Welcome to the Stock Picker method!"
#puts "Enter a list of daily prices separated by commas:"
#price_list << gets.chomp
#price_list = [list.split]
#puts price_list
#stock_picker(price_list)