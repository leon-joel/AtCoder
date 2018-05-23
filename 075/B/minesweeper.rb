class Grid
  attr_reader :h, :w
  attr_accessor :grid

  def initialize(h, w)
    @h = h
    @w = w
    @grid = []
  end

  DIRS = [ [-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

  def count_mine(r, c)
    cnt = 0

    DIRS.each do |(dr, dc)|
      cr = r + dr
      cc = c + dc

      next if cr < 0 || @h <= cr
      next if cc < 0 || @w <= cc

      cnt += 1 if @grid[cr][cc] == "#"
    end
    cnt
  end

  def replace_mine_count
    0.upto @h-1 do |r|
      0.upto @w-1 do |c|
        if @grid[r][c] == "."
          @grid[r][c] = count_mine(r, c)
        end
      end
    end
  end

  def print_result
    @grid.each do |row|
      0.upto(@w-1) do |c|
        print row[c]
      end
      puts
    end
  end

end

def main
  h, w = ARGF.gets.split.map(&:to_i)

  g = Grid.new(h, w)
  h.times do
    g.grid << ARGF.gets.chars
  end

  g.replace_mine_count

  g.print_result
end

if __FILE__ == $0
  main
end
