n500 = gets.chomp.to_i
n100 = gets.chomp.to_i
n50 = gets.chomp.to_i
amount = gets.chomp.to_i
# puts "#{n500}, #{n100}, #{n50}: #{amount}"

# 解答
pattern_num = 0

# 500円玉を使える最大枚数
max500 = [amount / 500, n500].min

0.upto(max500) do |cur500|
  rest = amount - 500 * cur500

  # 100円玉を使える最大枚数
  max100 = [rest / 100, n100].min

  0.upto max100 do |cur100|
    rest_inner = rest - 100 * cur100

    # 必要な50円玉の枚数 ※ここは必ず割り切れる
    cur50 = rest_inner / 50

    # 持っている枚数以下ならパターンとして有効
    if cur50 <= n50
      pattern_num += 1
    end
  end
end

puts pattern_num
