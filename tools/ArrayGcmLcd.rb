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

# 使用法: トップレベルに以下の行を入れる
# using ArrayRefinement
