require 'pp'

def gets; ARGF.gets; end

def main
  # prng = Random.new
  # 100000.times do
  #   print "#{prng.rand(1000000000)} "
  # end
  # exit

  n, m = gets.split.map(&:to_i)

  # ハッシュ: 累積mod -> その個数
  accum_mod_hash = Hash.new(0)
  accum_mod = 0
  gets.split.each do |s|
    accum_mod = (s.to_i + accum_mod) % m
    accum_mod_hash[accum_mod] += 1
  end
  # pp accum_mod_hash

  ans = accum_mod_hash.inject(0) do |sum, (k, v)|
    if k == 0
      sum += v * (v+1) / 2
    else
      sum += (v-1) * (v) / 2
    end
    sum
  end

  puts ans

  # ans = 0
  # 0.upto(nums.length-1) do |i|
  #   m0 = nums[i]
  #
  #   # 起点が0、つまりその箱だけで条件を満たしている
  #   ans += 1 if m0 == 0
  #
  #   # 後に続く m0 と同じ値をカウントアップする
  #   (i+1).upto(nums.length-1) do |j|
  #     ans += 1 if nums[j] == m0
  #   end
  # end
  #
  # puts ans
end

if __FILE__ == $0
  main
end
