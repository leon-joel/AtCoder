require 'pp'

def gets; ARGF.gets; end

def main
  n = gets.chomp.to_i

  frames = gets.split.map(&:to_i)
  ave = frames.inject(:+).to_f / n

  min_dist = 100
  min_idx = 1000
  frames.each_with_index do |f, idx|
    dist = (f - ave).abs
    if dist == 0.0
      puts idx
      return
    elsif dist < min_dist
      min_dist = dist
      min_idx = idx
    end
  end
  puts min_idx
end

if __FILE__ == $0
  main
end
