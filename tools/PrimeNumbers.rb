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

if __FILE__ == $0
  # Ruby には prime という標準ライブラリがあるので、
  # 素数に関する処理を自前で書く必要はほぼないかもしれない。
  # https://qiita.com/kanetai/items/dc8a79cd08d5a0ebd05f

  # 素因数分解
  require 'prime'
  Prime.prime_division(454085)  #=> [[5, 1], [197, 1], [461, 1]]

  # n! を素因数分解
  pns = Hash.new(0)
  2.upto(n) do |x|
    a = Prime.prime_division(x) #=> [[5, 1], [197, 1], [461, 1]]
    # pp "#{x}: #{a}"
    pns.merge!(a.to_h) do |k, old_val, new_val|
      old_val + new_val
    end
  end
  # pp "#{n}: #{pns}" #=> {2=>97, 3=>48, 5=>24,...}
end
