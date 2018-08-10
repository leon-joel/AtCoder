require 'pp'

def main
  nums_cnt = ARGF.gets.chomp.to_i
  nums = ARGF.gets.split.map(&:to_i)

  # 累積和
  s = 0
  accum_ary = nums.map do |n|
    s += n
    s
  end
  # pp accum_ary

  min_diff = nil

  # 2番目（真ん中）の区切りを決める
  # m_idx=2 の場合、2の前が区切り という意味
  l = 1
  r = 3
  2.upto(nums.length-2) do |m_idx|
    # しゃくとり法
    l_side_sum = accum_ary[m_idx-1] # left側の合計

    side_min_diff = nil
    ll_sum = lr_sum = 0
    # 左サイドの分割位置
    l.upto(m_idx-1) do |i|
      ll = accum_ary[i-1]
      lr = l_side_sum - ll
      diff = (ll - lr).abs
      if side_min_diff.nil? || diff < side_min_diff
        ll_sum, lr_sum = ll, lr
        side_min_diff = diff
        l = i
      else
        # 更新しなかった＝右端が行き過ぎた！
        break
      end
    end

    # しゃくとり法
    r_side_sum = accum_ary[-1] - l_side_sum # right側の合計

    side_min_diff = nil
    rl_sum = rr_sum = 0
    # 右サイドの分割位置
    r.upto(nums.length-1) do |i|
      rl = accum_ary[i-1] - l_side_sum
      rr = r_side_sum - rl
      diff = (rl - rr).abs
      if side_min_diff.nil? || diff < side_min_diff
        rl_sum, rr_sum = rl, rr
        side_min_diff = diff
        r = i
      else
        # 更新しなかった＝右端が行き過ぎた！
        break
      end
    end

    min, max = [ll_sum, lr_sum, rl_sum, rr_sum].minmax
    diff = max - min
    min_diff = diff if min_diff.nil? || diff < min_diff
  end

  puts min_diff
end

if __FILE__ == $0
  main
end
