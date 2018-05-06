# 素数探索（エラトステネスの篩）
# - 2の倍数を最初から除外してみた
# @param limit 探索する範囲（最大の整数）
# @return [Array] 素数配列
def eratosthenes(limit)
  # 探索リスト
  search_list = []
  3.upto limit do |i|
    search_list << i if i.odd?
  end
  # p search_list

  # 探索結果（素数配列）
  primes = [2]

  # 最後に見つかった素数がコレを越えたら探索終了（残りは全て素数）
  root_limit = Math.sqrt(limit)

  while (prime = search_list.shift) do
    # 探索リストの先頭は必ず素数
    primes << prime

    # primeが√limit を越えたら、残りは全て素数
    if root_limit < prime
      primes.concat(search_list)
      break
    end

    # primeの倍数を全て除去
    search_list.reject! { |i| i % prime == 0 }
  end

  primes
end


num = gets.chomp.to_i

# 『5で割って余り1』になる素数だけを集める
# ※55555までだと該当するのが1408個もある。該当数を55個見つければOKなので。
prime_numbers = eratosthenes(1500).select {|n| n % 5 == 1}
# puts "Len: #{prime_numbers.length}"
# puts prime_numbers

# 先頭から必要な数の部分配列を返す
ans_nums = prime_numbers[0, num]
puts ans_nums.join(" ")
