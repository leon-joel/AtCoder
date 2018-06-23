def main

  n, k = ARGF.gets.split.map(&:to_i)
  nums = ARGF.gets.split.map(&:to_i)

  # 1 の場所を探す
  pos1 = nums.find_index(1)


  # # k = 3
  # # pos1 = 3
  # #   . . . 1
  # # 下に2(k-1)ずつ拾っていき、何回で先頭に到達する？
  # head_cnt = (pos1+(k-2)) / (k - 1)
  #
  # # 上も同様
  # # num.count = 6
  # # pos1 = 3
  # #   . . . 1 . .
  # tail_cnt = (nums.count - pos1 - 1 + (k-2)) / (k - 1)
  #
  # # puts "#{nums.count}: #{pos1}: #{head_cnt}:#{tail_cnt}"
  # puts head_cnt + tail_cnt
  #
  # # k = 4 つまり3ずつ拾う
  # # 0 1 2 3 4 5 6 7 8 9 10
  # # 0 0 0 1 1 1 2 2 2 3 3
  # # 0 1 1 1 2 2 2 3 3 3 4

  # 上のはまたぎパターンに対応出来てなかった

  # これは正解！
  # puts (nums.count - 1 + (k-2)) / (k - 1)

  # 浮動小数割り算を使うと幾分わかりやすいかも ※割られる数が0のときは商が0、1のときは1という性質なので
  puts ((n - 1).to_f / (k - 1)).ceil
end

if __FILE__ == $0
  main
end
