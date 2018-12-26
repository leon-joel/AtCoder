require 'pp'

def gets; ARGF.gets; end

class Solver
  def main
    n = gets.chomp.to_i
    # s = gets.chomp      # 文字列のママ
    # s = gets.chomp.chars  # 配列化すると文字列のママより3倍くらい速い！
    # DMCを数値化して、更に2倍以降高速化！
    # s = gets.chomp.chars.map do |c|
    #   case c
    #   when 'D' then 0
    #   when 'M' then 1
    #   when 'C' then 2
    #   else nil
    #   end
    # end

    # DとMの数は累積和で保持する ★ただし、i番目の前までの和 を格納する
    d_accum = Array.new(n+1)
    m_accum = Array.new(n+1)
    d_sum = 0
    m_sum = 0
    s = Array.new(n)
    gets.chomp.each_char.with_index do |c, i|
      d_accum[i] = d_sum
      m_accum[i] = m_sum
      case c
      when 'D'
        s[i] = 0
        d_sum += 1
      when 'M'
        s[i] = 1
        m_sum += 1
      when 'C'
        s[i] = 2
      end
    end
    d_accum[-1] = d_accum[n-1]
    m_accum[-1] = m_accum[n-1]
    # pp d_accum
    # pp m_accum
    # pp s

    _ = gets.chomp.to_i
    k_ary = gets.split.map(&:to_i)

    # k-1 の一定長区間を考える。
    # 左端から始めて、
    # その区間を1つずつ右にずらしながら、
    # 区間内に存在する
    # ・Dの数
    # ・Mの数
    # ・D-M の組数
    # を常に把握するものとする。

    # 区間の右隣に C が来たときに、
    # 現在のD-M組数をans に加算する。

    k_ary.each do |k|
      sect_len = k - 1
      dm_num = 0
      ans = 0
      l = 0
      # 右端のindexをインクリメントしていく
      0.upto(n-1) do |r|
        # 左端
        l = r - sect_len if 0 <= r - sect_len
        # 追加される文字の処理
        c = s[r]
        if c == 2 #'C'
          ans += dm_num
        elsif c == 1 #"M"
          dm_num += d_accum[r] - d_accum[l]
        end

        # 左端から区間外に飛び出す文字の処理
        if 0 <= r - sect_len
          lc = s[l]
          if lc == 0 #"D"
            dm_num -= m_accum[r+1] - m_accum[l]
          end
        end
      end

      puts ans
    end
  end

  DMC = ['D', 'M', 'C'].freeze
  def make_dmc_string(num)
    s_ary = Array.new(num)
    rand = Random.new
    num.times do |i|
      r = rand.rand(3)
      s_ary[i] = DMC[r]
    end
    puts s_ary.join
  end
end

if __FILE__ == $0
  Solver.new.main
  # Solver.new.make_dmc_string(10000)
end
