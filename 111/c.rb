require 'pp'

def gets; ARGF.gets; end

def main
  n = gets.chomp.to_i

  # 数列を読み込み、
  # 数字ごとに出現数をカウントする * 2本（偶数列、奇数列
  even_nums = Hash.new(0)
  odd_nums = Hash.new(0)
  gets.split.each_with_index do |c, idx|
    num = c.to_i
    if idx.even?
      even_nums[num] += 1
    else
      odd_nums[num] += 1
    end
  end
  # pp even_nums
  # pp odd_nums

  # 出現数がMAXの数字＆カウント、および出現数が2番目のカウントを見つける
  # 2本
  evens = even_nums.sort_by {|(k, v)| v}
  odds = odd_nums.sort_by {|(k, v)| v }
  # pp evens
  # pp odds

  e_max, e_max_cnt = evens[-1]
  o_max, o_max_cnt = odds[-1]
  # puts e_max, e_max_cnt
  # puts o_max, o_max_cnt

  # 出現数MAXの数字が偶奇で異なっていれば、それで決定
  if e_max != o_max
    puts n - e_max_cnt - o_max_cnt
    return
  end

  # 同じであれば、MAX数字＋2番目数字 で両サイドカウントして
  # より多い方（変更数が少ない方）で決定
  e_max2_cnt = if evens.length == 1
                 0
               else
                 evens[-2][1]
               end
  o_max2_cnt = if odds.length == 1
                 0
               else
                 odds[-2][1]
               end
  eo = e_max_cnt + o_max2_cnt
  oe = o_max_cnt + e_max2_cnt

  if eo < oe
    puts n - oe
  else
    puts n - eo
  end
end

if __FILE__ == $0
  main
end
