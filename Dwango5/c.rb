require 'pp'

def gets; ARGF.gets; end

class Solver
  def main
    n = gets.chomp.to_i

    # D/M数, DM組数を累積和で保持する ★i番目の前までの和 を格納する
    d_sum = 0
    m_sum = 0
    dm_sum = 0
    s = Array.new(n)
    # [ [c, d_sum, m_sum, dm_sum] ... ]
    gets.chomp.each_char.with_index do |c, i|
      case c
      when 'D'
        s[i] = [1, d_sum, m_sum, dm_sum]
        d_sum += 1
      when 'M'
        s[i] = [2, d_sum, m_sum, dm_sum]
        m_sum += 1
        dm_sum += d_sum
      when 'C'
        s[i] = [3, d_sum, m_sum, dm_sum]
      else
        s[i] = [0, d_sum, m_sum, dm_sum]
      end
    end
    # pp d_accum
    # pp m_accum
    # pp dm_accum

    _ = gets.chomp.to_i
    k_ary = gets.split.map(&:to_i)

    # k の一定長区間を考える。
    # 区間の右端に C が来たときに、
    # 当該区間内のDM数を算出する。
    # DM数 = dm[r] - dm[l]
    #        - d[l] * (m[r] - m[l])
    k_ary.each do |k|
      sect_len = k - 1
      ans = 0
      l = 0
      # 右端のindexをインクリメントしていく
      2.upto(n-1) do |r|
        # 左端
        ra = s[r]
        if ra[0] == 3 #'C'
          l = r - sect_len if 0 <= r - sect_len
          la = s[l]
          # dm_r = dm_accum[r]
          # dm_l = dm_accum[l]
          # d_l = d_accum[l]
          # m_r = m_accum[r]
          # m_l = m_accum[l]
          # ans += dm_accum[r] - dm_accum[l] - d_accum[l] * (m_accum[r] - m_accum[l])
          ans += ra[3] - la[3] - la[1] * (ra[2] - la[2])
        end
      end

      puts ans
    end
  end

  # DMC = ['D', 'M', 'C'].freeze
  # def make_dmc_string(num)
  #   s_ary = Array.new(num)
  #   rand = Random.new
  #   num.times do |i|
  #     r = rand.rand(3)
  #     s_ary[i] = DMC[r]
  #   end
  #   puts s_ary.join
  # end
end

if __FILE__ == $0
  Solver.new.main
  # Solver.new.make_dmc_string(10000)
end
