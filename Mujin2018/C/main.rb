# require 'pp'

def main
  height, width = ARGF.gets.split.map(&:to_i)

  grid = Array.new(height)
  height.times do |r|
    s = 0
    row = ARGF.gets.chars.map do |ch|
      if ch != "#"
        # 左右のスペース数, 上下のスペース数
        # ※左のスペース数は読み込み時に格納しておく
        row = [s, 0]
        s += 1
        row
      end
    end
    grid[r] = row
  end

  # 右・上・左 方向の壁or障害物までの距離（隣が壁なら0）
  0.upto height-1 do |r|
    s = 0
    (width-1).downto 0 do |c|
      cell = grid[r][c]
      if cell.nil?
        s = 0   # スペース数をリセット
      else
        cell[0] += s
        s += 1
      end
    end
  end

  0.upto width-1 do |c|
    s = 0
    0.upto height-1 do |r|
      cell = grid[r][c]
      if cell.nil?
        s = 0   # スペース数をリセット
      else
        cell[1] += s
        s += 1
      end
    end
  end

  ans = 0

  0.upto width-1 do |c|
    s = 0
    (height-1).downto 0 do |r|
      cell = grid[r][c]
      if cell.nil?
        s = 0   # スペース数をリセット
      else
        cell[1] += s
        s += 1

        # 右折点を中心に考えて、
        # (上下のスペース数) * (左右のスペース数) が始点終点の順序対の数
        ans += cell[0] * cell[1]
      end
    end
  end
  # pp grid

  puts ans
end

if __FILE__ == $0
  main
end
