def main
  n, m, d = ARGF.gets.split.map(&:to_i)
  # puts "#{n}, #{m}, #{d}"

  # お隣の組み合わせ（順列）
  p = n * n

  # お隣組のうち美しいのは
  b_num = if d == 0
            n
          else
            (n - d) * 2
          end

  # 確率（期待値）
  b_exp = b_num.to_f / p

  # 数字の「間」が m-1 こあるので平均美しさは
  puts b_exp * (m - 1)

end

if __FILE__ == $0
  main
end
