class Node
  attr_accessor :parent, :rank

  def initialize(n)
    @parent = n
    @rank = 0
  end
end

class UnionFindTree
  def initialize(n)
    @nodes = (0..n).to_a.map { |i| Node.new(i) }
  end

  def find(x)
    return x if @nodes[x].parent == x

    @nodes[x].parent = find(@nodes[x].parent)
  end

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

  def same?(a, b)
    find(a) == find(b)
  end
end

def main
  n, m = ARGF.gets.split.map(&:to_i)
  # puts("Error") if n <= 0

  seq = ARGF.gets.split.map(&:to_i)
  # pp seq

  # グループ分け
  nft = UnionFindTree.new(n)
  m.times do
    p0, p1 = ARGF.gets.split.map(&:to_i)
    nft.unite(p0, p1)
  end

  match_num = 0
  pos = 1
  seq.each do |num|
    if num == pos
      # 既に所定の位置にある場合は即インクリメント
      match_num += 1

    elsif nft.same?(pos, num)
      # pickした数字を所定の位置に持っていけるか？
      # 現在のpos数 と pickした数字 が同じGroup なら持っていける
      match_num += 1
    end

    pos += 1
  end

  puts match_num
end

if __FILE__ == $0
  main
end
