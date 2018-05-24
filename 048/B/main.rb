def main
  lower, upper, x = ARGF.gets.split.map(&:to_i)

  lower_divx = (lower - 1) / x
  upper_divx = upper / x

  puts upper_divx - lower_divx
end

if __FILE__ == $0
  main
end

# diff  div
#    6    2    2個 or 3個の場合
#
# 0 5   5    1    2
# 1 6             2
# 2 7             2
# 3 8             2
#
# 0 4   4    1    2
# 1 5   4    1    1
# 2 6   4    1    2
# 3 7   4    1    2
#
# 0 3   3    1    2個
# 1 4   3         1
# 2 5   3         1
#
# 0 2   2    0    1個
# 1 3   2
# 2 4   2
#
# 0 1   1    0    1
# 1 2   1         0
# 2 3   1         1
#

# 0 1  1
# 1 2  0
# 2 3  0
# 3 4  1
# 4 5  1
# 5 6  0
# 6 7  0
# 7 8  1
#
# 0 2  1
# 1 3  0
# 2 4  1
# 3 5  1
# 4 6  1
# 5 7  0
# 6 8  1
#
# 0 3  1
# 1 4  1
# 2 5  1
# 3 6  1
# 4 7  1
# 5 8  1



