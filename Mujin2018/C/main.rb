require 'pp'

def main
  height, width = ARGF.gets.split.map(&:to_i)

  grid = Array.new(height)
  height.times do |r|
    s = 0
    row = ARGF.gets.chomp.chars.map do |ch|
      if ch == "#"
        s = 0
        nil
      else
        # 左のスペース数をカウントアップしながらセットしておく
        cell = [s, 0]
        s += 1
        cell
      end
    end

    # 右からのスペース数をカウントアップ
    s = 0
    (width-1).downto 0 do |c|
      cell = row[c]
      if cell.nil?
        s = 0   # スペース数をリセット
      else
        cell[0] += s
        s += 1
      end
    end

    # 上からのスペース数をカウントアップ
    if 0 < r
      upper_row = grid[r-1]
      0.upto width-1 do |c|
        cell = row[c]
        next if cell.nil?
        upper_cell = upper_row[c]
        next if upper_cell.nil?

        cell[1] = upper_cell[1] + 1
      end
    end

    grid[r] = row
  end

  # pp grid

  # 右・上・左 方向の壁or障害物までの距離（隣が壁なら0）
  # 0.upto height-1 do |r|
  #   s = 0
  #   (width-1).downto 0 do |c|
  #     cell = grid[r][c]
  #     if cell.nil?
  #       s = 0   # スペース数をリセット
  #     else
  #       cell[0] += s
  #       s += 1
  #     end
  #   end
  # end

  # 0.upto width-1 do |c|
  #   s = 0
  #   0.upto height-1 do |r|
  #     cell = grid[r][c]
  #     if cell.nil?
  #       s = 0   # スペース数をリセット
  #     else
  #       cell[1] += s
  #       s += 1
  #     end
  #   end
  # end

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
