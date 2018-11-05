require 'pp'

def gets; ARGF.gets; end

def main
  h, w, k = gets.split.map(&:to_i)

end

if __FILE__ == $0
  main
end
