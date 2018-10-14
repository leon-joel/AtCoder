require 'pp'

def gets; ARGF.gets; end

def calc_cost(garbage, from)
  from.upto(garbase.length-1) do |i|
    # i番目までの距離
    dist = garbage[i]
  end
  garbage[from]
end

def main
  @g_num, @g_cost = gets.split.map(&:to_i)

  garbage = gets.split.map(&:to_i)

  total_cost = calc_cost(garbage, 0)

  puts total_cost
end

if __FILE__ == $0
  main
end
