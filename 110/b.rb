require 'pp'

def gets; ARGF.gets; end

def main
  n, m, x, y = gets.split.map(&:to_i)
  # pp [n, m, x, y]

  x_max = gets.split.map(&:to_i).max
  y_min = gets.split.map(&:to_i).min

  x_max = [x, x_max].max
  y_min = [y, y_min].min
  # pp [x_max, y_min]

  if x_max < y_min
    puts 'No War'
  else
    puts 'War'
  end

end

if __FILE__ == $0
  main
end
