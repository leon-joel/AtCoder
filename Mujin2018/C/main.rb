# require 'pp'

D = 0
R = 1
U = 2
L = 3

def to_dir_str(d)
  case d
  when D then "D"
  when R then "R"
  when U then "U"
  when L then "L"
  else "ERROR!!!"
  end
end

# D,R,U,L のベクトル、およびその方向の逆
DIRS = [ [1, 0, U],
         [0, 1, L],
         [-1, 0, D],
         [0, -1, R] ]

# [D, R, U, L] に対して、右折した方向
DIRS2 = [L, D, R, U]

# グリッド範囲外？
def is_ob(h, w, r, c)
  r < 0 || h <= r || c < 0 || w <= c
end

def main
  height, width = ARGF.gets.split.map(&:to_i)

  grid = []
  height.times do |r|
    row = ARGF.gets&.chomp&.chars.map.with_index do |ch, c|
      # 下・右・上・左 方向の壁までの距離（隣が壁なら0）
      ch == "#" ? 1 : [height-r-1, width-c-1, r, c]
    end
    grid << row
  end
  # pp grid
  # grid[h][w]

  # 各セルから4方向にどれだけスペースが続いているかを調べる
  0.upto height-1 do |r|
    0.upto width-1 do |c|
      next if grid[r][c] != 1

      DIRS.each do |(dr, dc, rdir, _)|
        sr = r
        sc = c

        dist = 0
        loop do
          sr += dr
          sc += dc

          # 範囲外なら次の方向に
          break if is_ob(height, width, sr, sc)
          # 障害物が出てきたら次の方向に
          cell = grid[sr][sc]
          break if cell == 1

          cell[rdir] = dist
          dist += 1
        end
      end
    end
  end
  # pp grid

  ans = 0

  0.upto height-1 do |r|
    0.upto width-1 do |c|
      cell = grid[r][c]
      next if cell == 1

      # スペースがある各方向に進み、
      # 進んだセルの右折方向にどれだけスペースがあるかを加算していく
      cell.each_with_index do |ds, dir|
        sr = r
        sc = c
        ds.times do
          sr += DIRS[dir][0]
          sc += DIRS[dir][1]
          a = grid[sr][sc][DIRS2[dir]]
          ans += a

          # puts "(#{r},#{c}) => #{to_dir_str(dir)} (#{sr},#{sc}) : #{a}"
        end
      end
    end
  end

  puts ans
end

if __FILE__ == $0
  main
end
