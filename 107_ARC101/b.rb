require 'pp'

def gets; ARGF.gets; end

# 32bit整数
INT_MAX = 2147483647
UINT_MAX = 4294967295
# 64bit整数
LONGLONG_MAX = 9223372036854775807
ULONGLONG_MAX = 18446744073709551615

class Solver
  def main
    h, w = gets.split.map(&:to_i)

    bs = Array.new(w, 0)
    grid = []
    h.times do
      s = gets.chomp

      found_black = false
      s.each_char.with_index do |c, i|
        if c == '#'
          # 黒マスが存在する列は1にしていく
          bs[i] = 1
          found_black = true
        end
      end

      # 黒マスが1つでもあれば、文字列全体をgridに入れていく
      if found_black
        grid << s
      end
    end

    grid.each do |s|
      s.each_char.with_index do |c, i|
        if bs[i] == 1
          print c
        end
      end
      puts
    end
  end
end

if __FILE__ == $0
  Solver.new.main
end
