module RangeExtension
  refine Range do
    def intersection(other)
      raise ArgumentError, 'value must be a Range' unless other.kind_of?(Range)

      my_min, my_max = first, exclude_end? ? max : last
      other_min, other_max = other.first, other.exclude_end? ? other.max : other.last

      new_min = self === other_min ? other_min : other === my_min ? my_min : nil
      new_max = self === other_max ? other_max : other === my_max ? my_max : nil

      new_min && new_max ? new_min..new_max : nil
    end

    alias_method :&, :intersection
  end
end

using RangeExtension

class TPoint
  attr_accessor :idx, :range, :nodes

  def initialize(i, range, node)
    @idx = i
    @range = range

    @nodes = Array.new

    if node
      @nodes << node
    end
  end

  def update_ranges(r)

  end
end


def main
  # 頂点、辺
  n, m = ARGF.gets.split.map(&:to_i)

  ps = Array.new(n)

  m.times do
    # 頂点、頂点、合計点
    u, v, s = ARGF.gets.split.map(&:to_i)

    if ps[u].nil? && ps[v].nil?
      ps[v] = TPoint.new(u, 1..s, nil)
      ps[u] = TPoint.new(u, 1..s, ps[v])
    elsif ps[u].nil?
      v = ps[v]
      r = v.range.intersection(1..s)
      puts(0) if r.nil?
      ps[v].range = r
      ps[u] = TPoint.new(u, r, ps[v])

    end
  end

  sum = nums.inject(&:+)

  min_diff = 10**9
  1.upto(nums.length - 3) do |c1|
    r1_sum = nums.slice(0, c1).inject(&:+)

    1.upto(nums.length - 2 - c1) do |c2|
      r2_sum = nums.slice(c1, c2).inject(&:+)

      1.upto(nums.length - 1 - c1 - c2) do |c3|
        r3_sum = nums.slice(c1+c2, c3).inject(&:+)

        r4_sum = sum - (r1_sum + r2_sum + r3_sum)

        min, max = [r1_sum, r2_sum, r3_sum, r4_sum].minmax
        d = max - min

        if d < min_diff
          min_diff = d
        end
      end
    end
  end

  puts min_diff
end

if __FILE__ == $0
  main
end
