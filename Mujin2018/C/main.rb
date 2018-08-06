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
        # [ 左右のスペース, 上のスペース, 下のスペース]
        cell = [s, 0, 0]
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

  ans = 0

  # 下からのスペースをカウントアップ
  (height-1).downto 0 do |r|
    row = grid[r]
    lower_row = grid[r+1]
    0.upto width-1 do |c|
      cell = row[c]
      next if cell.nil?

      if !lower_row.nil?
        lower_cell = lower_row[c]
        if !lower_cell.nil?
          cell[2] = lower_cell[2] + 1
        end
      end

      # 右折点を中心に考えて、
      # (左右のスペース数) * (上下のスペース数)が始点終点の順序対の数
      ans += cell[0] * (cell[1] + cell[2])
    end
  end
  # pp grid

  puts ans
end

if __FILE__ == $0
  main
end
