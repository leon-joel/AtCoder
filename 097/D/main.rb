require 'pp'
require 'set'

def find_group(groups, n)
  groups.find do |g, _|
    g.include? n
  end
end

def main
  _, m = ARGF.gets.split.map(&:to_i)
  # puts("Error") if n <= 0

  seq = ARGF.gets.split.map(&:to_i)
  # pp seq

  # グループ分け
  groups = []
  m.times do
    pair = ARGF.gets.split.map(&:to_i)

    # 所属グループを探す
    g0 = find_group(groups, pair[0])
    g1 = find_group(groups, pair[1])

    if g0.nil? && g1.nil?
      # どこにも属してない ➾ 新規groupを作る
      groups << Set.new(pair)

    elsif !g0.nil? && !g1.nil?
      if g0 != g1
        # 別々のgroupに所属している ➾ マージする
        groups.delete(g1)
        g0.merge(g1)
      end
      # 同じgroupに属している場合はなにもしない

    elsif !g0.nil?
      # pair0 だけがgroupに所属している ➾ pair1をgroupに追加
      g0 << pair[1]
    elsif !g1.nil?
      g1 << pair[0]
    else
      puts "error"
    end
  end
  # pp groups

  #
  groups_with_index =
      groups.inject([]) do |groups_with_index, g|
        groups_with_index << [g, []]
      end

  match_num = 0
  # index探し
  pos = 1
  seq.each do |num|
    # groupを探す
    g = find_group(groups_with_index, num)
    if g.nil?
      if num == pos
        # グループに属していない && 既に所定の位置にある
        match_num += 1
      end

    else
      # グループに属している場合は、現在のposを記録しておく
      g[1] << pos
    end

    pos += 1
  end
  # pp groups_with_index

  # union
  groups_with_index.each do |(g, gpos)|
    match_num += (g & gpos).size
  end
  puts match_num

end

if __FILE__ == $0
  main
end
