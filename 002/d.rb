require 'pp'

def gets; ARGF.gets; end

def main
  n, m = gets.split.map(&:to_i)

  friends = Hash.new { |h, k| h[k] = [] }
  m.times do
    # お友達関係をHashに保持する ※0始まりに変換
    a, b = gets.split.map(&:to_i)
    friends[a-1] << b-1
    friends[b-1] << a-1
  end

  max_group_len = 1

  # combinationを使用した解法
  # ※Rubyの場合はcombinationがあるので、自分でbit全探索を実行する必要はほぼないかも

  # nC2〜nCn までのすべての組み合わせを列挙させる
  2.upto(n) do |i|
    [*0...n].combination(i) do |group|
      # 各組み合わせに含まれるすべての2人組が知り合い？
      is_ok = group.combination(2).all? do |(x, y)|
        # ※x,y の順序は不定とのことなので、
        #   friendsハッシュには両側向きの知り合い関係を格納している。
        #   ここで毎回ソートすれば、friendsハッシュには片側向きだけ格納すればOKになる。
        friends[x].include?(y)
      end

      max_group_len = i if is_ok
    end
  end


  # # bit mask の生成
  # # 2^n     = 1 << n
  # 0.upto((1 << n) - 1) do |mask|
  #   is_ok = true
  #   group = []
  #   # 各bitを下から舐める
  #   0.upto(n-1) do |i|
  #     # iビット目が立っているかどうか
  #     # ビットが立っている＝派閥に入れる候補
  #     if mask[i] == 1
  #       # 既に派閥入りしている人たち全員と知り合い関係がある？
  #       is_ok = group.all? do |member|
  #         friends[member].include?(i)
  #       end
  #       if is_ok
  #         # みんな知り合いだったので派閥に入れる
  #         group << i
  #       else
  #         break
  #       end
  #     end
  #   end
  #
  #   # 最大派閥更新？
  #   if is_ok && max_group_len < group.length
  #     max_group_len = group.length
  #   end
  # end

  puts max_group_len
end

if __FILE__ == $0
  main
end
