require 'pp'

def gets; ARGF.gets; end

def main
  x, y = gets.split.map(&:to_i)

  puts x + y / 2
end

if __FILE__ == $0
  main
end
