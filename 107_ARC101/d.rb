require 'pp'

def gets; ARGF.gets; end

def main
  n, m, q = gets.split.map(&:to_i)

  # 区間を2次元座標上にマッピングする
  # range_map[L][R]
  # ※l,r は1以上なので 0行/0列 は全て0のまま
  range_map = Array.new(n+1) {Array.new(n+1, 0)}
  m.times do
    l, r = gets.split.map(&:to_i)
    range_map[l][r] += 1
  end

  # 2次元累積和を求める
  1.upto(n) do |l|
    row_sum = 0
    1.upto(n) do |r|
      row_sum += range_map[l][r]
      range_map[l][r] = range_map[l-1][r] + row_sum
    end
  end
  # pp range_map

  # 問題解決
  q.times do
    p, q = gets.split.map(&:to_i)
    ans = range_map[q][q] - range_map[p-1][q] - range_map[q][p-1] + range_map[p-1][p-1]
    puts ans
  end
end

if __FILE__ == $0
  main
end
