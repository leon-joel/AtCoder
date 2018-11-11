require 'pp'

def gets; ARGF.gets; end

class XY
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
  def to_s
    "(#{@x},#{@y})"
  end
  def ==(other)
    @x == other.x && @y == other.y
  end
  def eql?(other)
    self.==(other)
  end
  def +(other)
    XY.new(@x + other.x, @y + other.y)
  end
end

module DIR
  U = XY.new(0, -1).freeze
  R = XY.new(1, 0).freeze
  D = XY.new(0, 1).freeze
  L = XY.new(-1, 0).freeze
end
DIRS = [DIR::U, DIR::R, DIR::D, DIR::L].freeze

class GameBoard
  attr_accessor :sq, :grid
  attr_accessor :pos, :dir_idx

  def initialize(sq)
    @grid = Array.new(sq)
    sq.times do |r|
      if r == 0 || r == sq-1
        @grid[r] = Array.new(sq, '#')
      else
        row = Array.new(sq)
        row[0] = '#'
        row[sq-1] = '#'
        1.upto(sq-2) do |c|
          row[c] = '.'
        end
        @grid[r] = row
      end
    end
    @sq = sq
    @grid
  end

  def print
    @grid.each do |row|
      puts row.join
    end
  end

  # 盤面を生成
  def generate(sq, cmds)
  end

  def move_forward
    dir = DIRS[@dir_idx]
    npos = @pos + dir

    if @grid[npos.y][npos.x] != "#"
      @pos = npos
    end
  end
  def turn_right
    if @dir_idx < 3
      @dir_idx += 1
    else
      @dir_idx == 0
    end
  end
  def turn_left
    if 0 < @dir_idx
      @dir_idx -= 1
    else
      @dir_idx = 3
    end
  end
  def turn(c)
    cell = @grid[@pos.y][@pos.x]

    if c == 'R'
      if cell == 'L'
        turn_left
      else
        turn_right
      end
    elsif c == 'L'
      if cell == 'R'
        turn_right
      else
        turn_left
      end
    end
  end

  # 1コマンド実行
  def move(c)
    t = if @grid[@pos.y][@pos.x] == "D"
          2
        elsif @grid[@pos.y][@pos.x] == "T"
          3
        else
          1
        end
    if c == 'S'
      t.times do
        move_forward
      end
    else
      t.times do
        turn(c)
      end
    end
  end

  # すべて操作して、最終地点ハッシュを返す
  def compute_result(cmds)
    dest_pos = Hash.new(0)
    cmds.each do |cmd|
      @pos = XY.new(@sq / 2, @sq / 2)
      @dir_idx = 0 # 上向き

      cmd.each do |c|
        move(c)
      end

      # 最終地点をカウントアップ
      dest_pos[@pos] += 1
    end
    dest_pos
  end
end


def main
  c_num, sq, c_len = ARGF.gets.split.map(&:to_i)

  cmds = Array.new(c_num)
  c_num.times do |i|
    cmds[i] = gets.chomp.chars
  end
  # puts cmds

  # 枠だけセットしたGridを作る
  board = GameBoard.new(sq)

  # 盤面生成
  board.generate(sq, cmds)

  # すべて操作
  dest_pos = board.compute_result(cmds)
  # puts dest_pos

  board.print
end

if __FILE__ == $0
  main
end
