require 'pp'

def gets; ARGF.gets; end

MOD_NUM = 998244353

class Solver
  def main
    n, m = gets.split.map(&:to_i)

    # 中心ラインの 2x2矩形 を線形に保持する
    @c_grid = Array.new((n-1) * 3 + 1)

    # 外側はHashで保持する (x, y) => c
    # ※ただし、y < x 側のみ格納
    @o_hash = Hash.new

    m.times do
      x, y, c = gets.split.map(&:to_i)
      x -= 1
      y -= 1
      if (x - y).abs <= 1
        # 中心ライン
        @c_grid[x * 2 + y] = c
      else
        # 外側ハッシュはy<x 側に変換して格納
        xy = if y <= x
               [x, y]
             else
               [y, x]
             end

        o_c = @o_hash[xy]
        if o_c.nil?
          @o_hash[xy] = c
        elsif o_c != c
          # 既に格納されていて矛盾がある場合は即return 0
          return puts 0
        end
      end
    end
    # pp @grid

    # 中心ラインで確定する色を埋めていく
    # 2x2矩形で 左上点 からスキャンしていく
    0.upto(n-2) do |i|
      c22 = @c_grid[i*3, 4]
      nil_cnt = c22.count(nil)
      next if nil_cnt == 4

      if nil_cnt == 0
        cnt_1 = c22.count(1)
        if cnt_1 != 4 && cnt_1 != 2 && cnt_1 != 0
          return puts 0
        end

      elsif nil_cnt == 1
        # 埋めていくのは 1-1-1 or 0-0-0 のみ
        case c22
        when [1, 1, 1, nil] then @c_grid[i*3 + 3] = 1
        when c22 == [1, 1, nil, 1] then @c_grid[i*3 + 2] = 1
        when c22 == [1, nil, 1, 1] then @c_grid[i*3 + 1] = 1
        when c22 == [nil, 1, 1, 1] then @c_grid[i*3 + 0] = 1
        when c22 == [0, 0, 0, nil] then @c_grid[i*3 + 3] = 0
        when c22 == [0, 0, nil, 0] then @c_grid[i*3 + 2] = 0
        when c22 == [0, nil, 0, 0] then @c_grid[i*3 + 1] = 0
        when c22 == [nil, 0, 0, 0] then @c_grid[i*3 + 0] = 0
        else
          # nilが1個でこれ以外のパターンはNG
          return puts 0
        end
      end
    end

    ans = 1

    # 中心ラインのパターン数
    c22 = @c_grid[0, 4]
    cnt_nil = c22.count(nil)
    case cnt_nil
    when 1 then return puts -1  # ありえない
    when 4 then ans = ans * 8 % MOD_NUM
    when 3 then ans = ans * 4 % MOD_NUM
    when 2 then ans = ans * 2 % MOD_NUM
    end

    1.upto(n-2) do |i|
      c22 = @c_grid[i*3, 4]
      cnt_nil = c22.count(nil)
      cnt_1 = c22.count(1)
      case cnt_nil
      when 1 then return puts -1  # ありえない
      when 4 then ans = ans * 4 % MOD_NUM
      when 3 then ans = ans * 2 % MOD_NUM
      when 2 then ans = ans * 1 % MOD_NUM
      end
    end

    # 外側のパターン数 = 2^(外側[片側]のセル数 - ハッシュに格納されている数)
    # 外側[片側]のセル数
    o_num = (n - 2) * (n - 1) / 2
    o_free_num = o_num - @o_hash.length
    o_free_num.times do |i|
      ans = ans * 2 % MOD_NUM
    end

    puts ans

  end
end

if __FILE__ == $0
  Solver.new.main
end
