require 'pp'

def gets; ARGF.gets; end

require 'prime'

PN = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97].freeze

# 素因数分解の結果pns から、指数が expo 以上の因数をカウントする
def count_pn(pns, expo)
  cnt = 0
  pns.count do |k, v|
    cnt += 1 if expo <= v
  end
  cnt
end

def main
  n = gets.chomp.to_i

  # 75数とは以下p,q,rの数式で表現できる数
  # ※以下、p, q, r は任意の素数を表す。
  #
  # 5*5*3 -> p^4 * q^4 * r^2
  # 15*5  -> p^14 * q^4
  # 25*3  -> p^24 * q^2
  # 75*1  -> p^74

  # n! を素因数分解
  pns = Hash.new(0)
  2.upto(n) do |x|
    a = Prime.prime_division(x) #=> [[5, 1], [197, 1], [461, 1]]
    # pp "#{x}: #{a}"
    pns.merge!(a.to_h) do |k, old_val, new_val|
      old_val + new_val
    end
  end
  # pp "#{n}: #{pns}"

  # 4通りのパターンいずれかに当てはまる n! の約数を数える
  # p^74 -> 74以上の指数を持つ素因数を数える
  # p^24 * q^2 -> 24以上の指数を持つ素因数の数 + (2以上の指数をもつ素因数の数 - 1)
  #               ※末尾 -1 は24以上の指数を持つ素因数の数を除くため
  # p^14 * q^4      -> 同上
  # p^4 * q^4 * r^2 -> 同上 / 2 ★pとqを入れ替えても同じ数になるので2で割っておく
  c74 = count_pn(pns, 74)

  c24 = count_pn(pns, 24)
  c2 = count_pn(pns, 2)

  c14 = count_pn(pns, 14)
  c4 = count_pn(pns, 4)

  # puts "75: #{c74}"
  # puts "25*3: #{c24} * #{c2-1}"
  # puts "15*5: #{c14} * #{c4-1}"
  # puts "5*5*3: #{c4} * #{c4-1} * #{c2-2}" / 2

  puts c74 + (c24 * (c2-1)) + (c14 * (c4-1)) + (c4 * (c4-1) * (c2-2) / 2)
end

if __FILE__ == $0
  main
end
