def gets; ARGF.gets; end

module ArrayRefinement
  refine Array do
    # 配列に対する最小公倍数
    def lcm
      self.inject(:lcm)
    end

    # 配列に対する最大公約数
    def gcd
      self.inject(:gcd)
    end
  end
end
using ArrayRefinement

def main
  s_len, t_len = gets.split.map(&:to_i)

  s = gets.chomp
  t = gets.chomp

  # s_len と t_len の最小公倍数 ＝ よい文字列の最短の長さ
  ans_len = [s_len, t_len].lcm
  # puts ans_len

  # 文字列SとTで共通の文字が必要なposition
  # S文字列の場合: (s_step * 0), (s_step * 1), (s_step * 2), ...
  # T文字列の場合: (t_step * 01), (t_step * 1), (t_step * 2), ...
  s_step = ans_len / t_len
  t_step = ans_len / s_len
  # puts [s_step, t_step]

  i = 0
  while true do
    s_pos = s_step * i
    t_pos = t_step * i

    break if s_len <= s_pos

    if s[s_pos] != t[t_pos]
      puts '-1'
      return
    end

    i += 1
  end

  puts ans_len
end

if __FILE__ == $0
  main
end
