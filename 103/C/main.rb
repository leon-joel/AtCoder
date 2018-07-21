module ArrayRefinement
  refine Array do
    def lcm
      self.inject(:lcm)
    end

    def gcd
      self.inject(:gcd)
    end
  end
end

using ArrayRefinement

def func(i, nums)
  nums.inject(0) do |sum, n|
    sum += i % n
  end
end

def main
  _ = ARGF.gets.chomp.to_i
  nums = ARGF.gets.split.map(&:to_i)

  puts nums.inject(0){|s, n|s += n-1}
end

if __FILE__ == $0
  main
end
