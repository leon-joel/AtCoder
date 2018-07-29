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
