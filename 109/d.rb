require 'pp'

def gets; ARGF.gets; end

def puts_move(m)
  puts "#{m[0]+1} #{m[1]+1} #{m[2]+1} #{m[3]+1}"
end

def main
  h, w = gets.split.map(&:to_i)
  grid = []

  h.times do |r|
     grid << gets.split.map(&:to_i)
  end

  moves = []

  # すべてのrowを右に見ていって奇数を右にずらしていく
  h.times do |r|
    row = grid[r]
    0.upto(w-2) do |c|
      if row[c].odd?
        row[c+1] += 1
        moves << [r, c, r, c+1]
      end
    end
  end

  # 一番右の列を上から見て、奇数を下にずらしていく
  0.upto(h-2) do |r|
    if grid[r][w-1].odd?
      grid[r+1][w-1] += 1
      moves << [r, w-1, r+1, w-1]
    end
  end

  puts moves.length
  moves.each do |m|
    puts_move(m)
  end
end

if __FILE__ == $0
  main
end
