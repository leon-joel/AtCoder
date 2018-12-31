require 'pp'

def gets; ARGF.gets; end

class Solver
  def main

    # 1桁
    1.upto(9) do |i|
      puts i
    end

    # 3桁
    1.upto(9) do |i3|
      1.upto(9) do |i2|
        1.upto(9) do |i1|
          a0 = i3 ** i2 * i1
          a1 = i3 * 100 + i2 * 10 + i1
          if a0 == a1
            puts a1
          end
        end
      end
    end

    # 5桁
    1.upto(9) do |i5|
      0.upto(9) do |i4|
        1.upto(9) do |i3|
          0.upto(9) do |i2|
            1.upto(9) do |i1|
              a0 = i5 ** i4 * i3 ** i2 * i1
              a1 = i5 * 10000 + i4 * 1000 + i3 * 100 + i2 * 10 + i1
              if a0 == a1
                puts a1
              end
            end
          end
        end
      end
    end

    # 7桁
    1.upto(9) do |i7|
      0.upto(9) do |i6|
        1.upto(9) do |i5|
          0.upto(9) do |i4|
            1.upto(9) do |i3|
              0.upto(9) do |i2|
                1.upto(9) do |i1|
                  a0 = i7 ** i6 * i5 ** i4 * i3 ** i2 * i1
                  a1 = i7 * 1000000 + i6 * 100000 + i5 * 10000 + i4 * 1000 + i3 * 100 + i2 * 10 + i1
                  if a0 == a1
                    puts a1
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

if __FILE__ == $0
  Solver.new.main
end
