require 'pp'

def gets; ARGF.gets; end

def main
  n, time_limit = gets.split.map(&:to_i)

  min_cost = 10000
  n.times do |i|
    cost, time = gets.split.map(&:to_i)
    next if time_limit < time

    min_cost = cost if cost < min_cost
  end

  if 1000 < min_cost
    puts 'TLE'
  else
    puts min_cost
  end
end

if __FILE__ == $0
  main
end
