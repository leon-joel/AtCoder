require 'pp'

def gets; ARGF.gets; end

MOD_NUM = 998244353

class Solver
  def main
    n, m = gets.split.map(&:to_i)

    # n^2 <= 10^10 なのでグリッドを保持できない

    # マス情報は MAX50000件なのでHashで保持する [x, y] => c

    # 対角線上
    @d_h = Hash.new
    # 対角線以外
    @o_h = Hash.new

    m.times do
      x, y, c = gets.split.map(&:to_i)
      x -= 1
      y -= 1
      xy = [x, y]

      if x == y
        # 対角線
        @d_h[x] = c
      else
        # 対角線以外
        @o_h[xy] = c
      end
    end
    # pp @d_h
    # pp @o_h

    # 対角線から右側の幅2 のセル情報 ※両サイドの和
    @i_h = Hash.new

    b_cnt = 0
    s_cnt = 0
    @o_h.each do |(x, y), c|
      # 逆サイド
      yx = [y, x]
      c_yx = @o_h[yx]

      if !c_yx.nil?
        b_cnt += 1
        # 両側指定だった場合
        if 3 <= (x - y).abs
          # 外側だった
          # 値が異なる＝矛盾 -> 即Return
          return puts 0 if c != c_yx

          # 値が同じ -> 何もしない
        else
          # 内側だった
          xy = (x <= y) ? [x, y] : [y, x]
          if c == c_yx
            # 値が同じ -> 0
            @i_h[xy] = 0
          else
            # 値が異なる -> 1
            @i_h[xy] = 1
          end
        end
      else
        s_cnt += 1
        # 片側だけ指定だった
        # 内側の場合=>もう片方の選択により1にも0にもでき一意に決まるので何もしない
        # 外側の場合⇒何もしない（自動的に反対側も一意に決まるので）
      end
    end

    ans = 0
    # bitDPで対角線上のセル値パターンをすべて列挙する
    # ★この方法ではパターン数が 2^n になり、TLE確実…

    # bit mask の生成
    # 2^n     = 1 << n
    0.upto((1 << n) - 1) do |mask|
      # 対角線上制約にマッチしている？
      is_fail = false
      @d_h.each do |i, c|
        next if c.nil?
        if mask[i] != c
          is_fail = true
          break
        end
      end
      next if is_fail

      # 対角線周辺制約にマッチしている？
      @i_h.each do |(x, y), c|
        if y - x == 1
          # a + b = c ?
          if c == 1
            is_fail = true if mask[x] == mask[y]
          elsif c == 0
            is_fail = true if mask[x] != mask[y]
          else
            return puts -2 # バグ
          end
        elsif y - x == 2
          # b = c ?
          is_fail = true if mask[x+1] != c
        else
          return puts -1 # バグ
        end
        break if is_fail
      end
      next if is_fail

      # ここまで来る＝この対角線上のセルパターンはOKだった
      ans += 1
    end

    # 対角線の片側で考えて
    # 両側どちらにも値が入っていないセル数＝対角線の片側セル数 - どちらかに値が入っているセル数
    v_cnt = n * (n - 1) / 2 - (s_cnt + b_cnt / 2)
    # puts "#{s_cnt}, #{b_cnt}, #{v_cnt}"
    # 2^v_cnt をの最後の答えに掛ける
    v_cnt.times do
      ans = ans * 2 % MOD_NUM
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
