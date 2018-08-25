require 'pp'

def gets; ARGF.gets; end

def main
  n = gets.chomp.to_i

  base = -2
  cur = 1
  div = base
  rest = n

  ans = []
  while true
    if rest % div != 0
      ans << 1
      rest -= cur
    else
      ans << 0
    end
    break if 0 == rest

    cur *= base
    div *= base
  end

  puts ans.reverse.join
end

if __FILE__ == $0
  main
end
