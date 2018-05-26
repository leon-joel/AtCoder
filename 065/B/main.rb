def main
  n = ARGF.gets.to_i

  buttons = ARGF.map(&:to_i)

  current = 0
  cnt = 1
  loop do
    next_num = buttons[current] - 1
    if next_num == 1
      # 所望の2番ボタンが光った！
      puts cnt
      return
    elsif next_num == -1
      # 既に押したボタンだった＝ループ状態に入った＝もうだめ
      puts "-1"
      return
    else
      # 押したボタンは0にしておく
      buttons[current] = 0
      cnt += 1
      current = next_num

      #
      # 0を入れていく方式ではなく、「N回トライしてみてだめだったらだめ」
      # という方式が模範解答だった。
    end
  end

  puts "-1"
end

if __FILE__ == $0
  main
end
