require 'pp'

def gets; ARGF.gets; end

class Solver
  def main
    @l, @n = gets.split.map(&:to_i)

    @trees = Array.new(@n)
    @n.times do |i|
      @trees[i] = gets.chomp.to_i
    end
    @trees.sort!

    # 遠い方に向かう
    pos = 0
    rev = false # homeを挟んで逆サイド（時計回り側）にいる
    ans = 0

    @n.times do
      d, pos, rev = move(pos, rev)
      ans += d
    end

    puts ans
  end

  def move(pos, rev)
    if rev
      # homeを挟んで逆サイド（時計回り側）にいる
      dist_t = @trees[0] + (@l - pos)
      dist_l = pos - @trees[-1]
    else
      # 順サイド（反時計回り側）にいる
      dist_t = @trees[0] - pos
      dist_l = pos + @l - @trees[-1]
    end

    rev = dist_t < dist_l

    if rev
      dist = dist_l
      pos = @trees[-1]
      @trees.delete_at(-1)
    else
      dist = dist_t
      pos = @trees[0]
      @trees.delete_at(0)
    end

    [dist, pos, rev]
  end
end

if __FILE__ == $0
  Solver.new.main
end
