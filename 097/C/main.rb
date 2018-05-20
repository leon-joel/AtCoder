def main
  s = ARGF.gets.chomp   # 1文字 〜 5000文字
  s_len = s.length

  k = ARGF.gets.to_i  # 1 <= K <= 5
  top_n = [k, 5].min

  top_n_subs = []
  'a'.upto('z') do |c|
    pos = 0
    while pos = s.index(c, pos)
      # puts "#{c}: #{pos}"

      # 何パターンある？
      pat_num = s_len - pos

      needs_num =
          if top_n <= pat_num
            # TOP5(or TOPK)だけをリストアップ
            top_n
          else
            # 全部リストアップ
            pat_num
          end

      subs = needs_num.downto(1).inject([]) do |subs, n|
        subs << s.slice(pos, n)
      end

      top_n_subs.concat(subs)
      top_n_subs.uniq!

      # 次の文字から探索
      pos += 1
    end

    # 1つの文字種が終わった段階でリストを確認する
    if top_n <= top_n_subs.length
      top_n_subs.sort!
      puts top_n_subs[top_n-1]
      return
    else
      # 次の文字種で求められるuniq数
      top_n -= top_n_subs.length
      top_n_subs = []   # リストはクリアしちゃってOK
    end
  end

  # ここまで来ることはない！
  puts "error"
end

if __FILE__ == $0
  main
end
