require 'pp'

def gets; ARGF.gets; end

def main
  s = gets.chomp
  if s.length == 3
    puts s.reverse
  else
    puts s
  end
end

if __FILE__ == $0
  main
end
