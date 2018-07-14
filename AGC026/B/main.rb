require "set"

def judge(morning, buy, thresh, adder)
  # 朝より購入のほうが多い -> 即NG
  return false if morning < buy

  # 購入より補充のほうが少ない -> 即NG
  return false if adder < buy

  # 購入よりしきい値のほうが多い -> 即OK
  # 購入-1 <= しきい値           -> 即OK
  return true if buy-1 <= thresh
  gap = buy - thresh  # かならず2以上

  # 初期処理
  # morningをthreshぎりぎりまで減らす
  if thresh < morning
    d = (morning - thresh) / buy
    morning -= buy * d
  end
  # adderもthreshぎりぎりまで減らす
  if thresh < adder
    d = (adder - thresh) / buy
    adder -= buy * d
  end

  s = morning
  s_ary = []
  inc = adder - buy

  while true do
    if s <= thresh
      # ここの回数を減らしたい！
      # s += adder
      # 単純に加算するのではなく、(adder-buy)ずつ増やしていって、threshを超えさせよう

      # 9  7 5 10
      # 9  2 12
      #    5 15
      #    8 8   --
      #    1 11
      #    4 14
      #    7 7   --
      #    0 10
      #    3 13
      #    6 6   xx
      #    x
      # thresh < s + (adder - buy) * XXX
      return true if inc == 0

      d = (thresh - s) / inc + 1
      s += inc * d
    else
      # 補充なしターン
      if s < buy
        return false
      end
      if s_ary.index(s)
        return true
      end
      # thresh上に出たところだけ記憶しておく
      s_ary << s
      if s_ary.count == 2
        # ここで判定できるはず
        # この等差数列がthreshより上 に入るかどうか
        s0, s1 = s_ary
        diff = s0 - s1
        if diff <= 0
          # 変化なしor 増えてる
          return true   # 根拠はない
        elsif diff < gap
          return false
        else
          mod_upper = (buy - 1) % diff
          mod_lower = (thresh + 1) % diff

          m = s1 % diff
          if mod_lower < mod_upper
            # 普通に比較して、範囲に入っていたらアウト！
            return !(mod_lower..mod_upper).include?(m)
          else
            return mod_lower <= m || m <= mod_upper
          end
        end
      end

      s -= buy
    end
  end

  # 14 10 8 12
  #     4
  # 16  6
  # 18  8
  # 20 10
  # 10  0
  # 20  0
end

def main
  t = ARGF.gets.to_i

  t.times do
    morning, buy, thresh, adder = ARGF.gets.split.map(&:to_i)


    #10 7 5 9
    #   3 12
    #   5 14
    #   7 7    --
    #   0 9
    #   2 11
    #   4 13
    #   6 6    xx
    #   x


    # 9 7 5 9
    # 9 2 11
    #   4 13
    #   6 6    xx
    #   x

    # 9 7 5 8
    # 9 2 10
    #   3 11
    #   4 12
    #   5 13
    #   6 6    xx
    #   x

    #
    # 16 10 5 10
    # 16 6 6     ※ここで在庫sが しきい値 < s < 補充量 となってしまった！
    #  6 x

    if judge(morning, buy, thresh, adder)
      puts 'Yes'
    else
      puts 'No'
    end
  end
end

if __FILE__ == $0
  main
end
