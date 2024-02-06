# Task:
# Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day.
# It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.
# Quick Tips:
# You need to buy before you can sell
# Pay attention to edge cases like when the lowest day is the last day or the highest day is the first day.


def count_diff results
  results[:sold_for] - results[:bought_for]
end

def stock_picker arr
  results = {bought_for: 0, sold_for: 0}
  arr.each_with_index do |wasted, index|
    earned = 0
    profit = arr.slice(index, arr.length-1).reduce(0) do |profit, price|
      if price-wasted > profit
          profit = price - wasted
          earned = price
      end
      profit
    end
    if count_diff results < profit
        results[:bought_for] = wasted
        results[:sold_for] = earned
    end
  end
  puts "#{best_profit} = #{sold} - #{bought}"
end

stock_picker([17,3,6,9,15,8,6,1,10])
