require 'pp'

def gets; ARGF.gets; end

def main
  age = gets.chomp.to_i
  if age == 1
    puts 'Hello World'
  else
    a = gets.chomp.to_i
    b = gets.chomp.to_i
    puts a + b
  end
end

if __FILE__ == $0
  main
end
