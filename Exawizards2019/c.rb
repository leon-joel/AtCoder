require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    @n, @q = gets.split.map(&:to_i)
    @s = gets.chomp
    # puts n, q

    @dirs = Array.new(@q)
    @q.times do |i|
      @dirs[i] = gets.split
    end
    # puts dirs

    # 二分探索で
    # ・左に出ていく最も右側のゴーレムの初期位置
    # ・右に出ていく最も左側のゴーレムの初期位置
    # を調べる
    # ゴーレムが他のゴーレムを追い抜くことはありえないので、
    # それらの外側のゴーレムはすべてどちらかのサイドに出ていくことになる。

    # まずは左に抜けていかない最も左側 を調べる
    ary = [*0...@n]  # 0 - (n-1) の配列
    lower = ary.bsearch_index do |i|
      is_ok(i)
    end
    # puts lower

    # 次に右に抜けていく最も左側 を調べる
    upper = ary.bsearch_index(&method(:is_ok_r))
    # puts upper

    ans = @n
    lower = @n if lower.nil?  # 全部左に抜ける
    if 0 < lower
      ans -= lower
    end
    upper = @n if upper.nil?
    if 0 < upper
      ans -= @n - upper
    end
    puts ans
  end

  private
  def is_ok(i)
    cur_i = i
    @dirs.each do |(ch, dir)|
      if @s[cur_i] == ch
        if dir == 'L'
          cur_i -= 1
          # 左に抜けた ＝条件を満たさない
          return false if cur_i < 0
        else
          cur_i += 1
          # 右に抜けた ＝左には抜けていかない＝条件を満たす
          return true if @n <= cur_i
        end
      end
    end
    # 生き残った ＝条件を満たす
    true
  end

  def is_ok_r(i)
    cur_i = i
    @dirs.each do |(ch, dir)|
      if @s[cur_i] == ch
        if dir == 'L'
          cur_i -= 1
          # 左に抜けた ＝条件を満たさない
          return false if cur_i < 0
        else
          cur_i += 1
          # 右に抜けた ＝条件を満たす
          return true if @n <= cur_i
        end
      end
    end
    # 生き残った ＝条件を満たさない
    false
  end
end

if __FILE__ == $0
  Solver.new.main
end
