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

  n, x = gets.split.map(&:to_i)

  nums = gets.split.map do |s|
    i = s.to_i
    i - x
  end

  puts nums.gcd.abs
end

if __FILE__ == $0
  main
end
