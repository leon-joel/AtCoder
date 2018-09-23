require 'pp'

def gets; ARGF.gets; end

def main
  a, b, c = gets.split.map(&:to_i).sort

  puts c * 10 + a + b
end

if __FILE__ == $0
  main
end
