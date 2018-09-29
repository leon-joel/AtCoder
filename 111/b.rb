require 'pp'

def gets; ARGF.gets; end

ABCS = [111, 222, 333, 444, 555, 666, 777, 888, 999]

def main
  n = gets.to_i

  ABCS.each do |abc|
    if n <= abc
      puts abc
      return
    end
  end
end

if __FILE__ == $0
  main
end
