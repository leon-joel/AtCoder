def main
  n = ARGF.gets.to_i

  # ords = Array.new(26, 0)
  # chars = ARGF.gets.chars.map do |c|
  #   ord = c.ord - 97
  #   ords[ord] += 1
  # end
  # kind_num = ords.count {|n| 1 <= n}
  # # puts ords
  # # puts kind_num
  #
  # common_kind_nums = 0
  # founds = Array.new(26)
  # nums = 0
  # chars.each do |ord|
  #   ords[ord] -= 1
  #   if founds[ord].nil?
  #     nums += 1
  #     founds[ord] = 1
  #   end
  #   k = nums + ords.count {|n| 1 <= n}
  #   if common_kind_nums < k
  #     common_kind_nums = k
  #   end
  #
  #   if common_kind_nums == kind_num
  #     puts kind_num
  #     return
  #   end
  # end
  # puts common_kind_nums

  ords = ARGF.gets.chars.map do |c|
    ord = c.ord - 97
  end

  k1 = 0
  founds = Array.new(26)
  max_common = 0
  0.upto(n-2) do |i|
    c = ords[i]
    if founds[c].nil?
      k1 += 1
      founds[c] = 1
    end

    f2 = founds
    common = 0
    (i+1).upto(n-1) do |i2|
      c2 = ords[i2]
      if f2[c2] == 1
        common += 1
        f2[c2] = nil
      end
    end

    if max_common < common
      max_common = common
    end
  end
  puts max_common
end

if __FILE__ == $0
  main
end
