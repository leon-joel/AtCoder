class Grid
  attr_reader :h, :w
  attr_accessor :grid

  def initialize(h, w)
    @h = h
    @w = w
    @grid = []
  end

  def count_mine(r, c)
    cnt = 0

    # 上のrow
    if 1 <= r
      row = @grid[r-1]
      # 左
      cnt += 1 if 1 <= c && row[c-1] == "#"
      # 中
      cnt += 1 if row[c] == "#"
      # 右
      cnt += 1 if c+1 < @w && row[c+1] == "#"
    end

    # 下のrow
    if r < @h-1
      row = @grid[r+1]
      # 左
      cnt += 1 if 1 <= c && row[c-1] == "#"
      # 中
      cnt += 1 if row[c] == "#"
      # 右
      cnt += 1 if c+1 < @w && row[c+1] == "#"
    end

    # 自分のrow
    row = @grid[r]
    # 左
    cnt += 1 if 1 <= c && row[c-1] == "#"
    # 右
    cnt += 1 if c+1 < @w && row[c+1] == "#"

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
