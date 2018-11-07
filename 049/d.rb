require 'pp'

def gets; ARGF.gets; end

class Node
  attr_accessor :parent, :rank

  def initialize(n)
    @parent = n
    @rank = 0
  end
end

class UnionFindTree
  # 0 から n まで（計 n+1個）のNodeを作る
  def initialize(n)
    @nodes = (0..n).to_a.map { |i| Node.new(i) }
  end

  # x要素のルート親を返す
  def find(x)
    return x if @nodes[x].parent == x

    @nodes[x].parent = find(@nodes[x].parent)
  end

  # a,b を同一グループ化する
  def unite(a, b)
    a = find(a)
    b = find(b)
    return if a == b

    if @nodes[a].rank < @nodes[b].rank
      @nodes[a].parent = b
    else
      @nodes[b].parent = a
      @nodes[a].rank += 1 if @nodes[a].rank == @nodes[b].rank
    end
  end

  # a,b が同一グループ？
  def same?(a, b)
    find(a) == find(b)
  end
end

def main
  c_num, p_num, r_num = gets.split.map(&:to_i)

  # 道路で行ける都市をグループ化
  path_tree = UnionFindTree.new(c_num)
  p_num.times do
    path_tree.unite(*gets.split.map(&:to_i))
  end

  # 鉄道で行ける都市をグループ化
  rail_tree = UnionFindTree.new(c_num)
  r_num.times do
    rail_tree.unite(*gets.split.map(&:to_i))
  end

  # 同じ親セットを持つ都市をカウントアップしていく
  groups = Hash.new(0)
  1.upto(c_num) do |i|
    pp = path_tree.find(i)
    rp = rail_tree.find(i)
    groups[[pp, rp]] += 1
  end

  # 同じ親セットをもつ都市数を出力
  nums = (1..c_num).inject([]) do |s, i|
    pp = path_tree.find(i)
    rp = rail_tree.find(i)
    s << groups[[pp, rp]]
  end
  puts nums.join(" ")
end

if __FILE__ == $0
  main
end
