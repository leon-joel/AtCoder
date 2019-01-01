require 'pp'

def gets; ARGF.gets; end

class Solver
  def main
    n = gets.chomp.to_i
    n.times do |c|
      i = gets.chomp.to_i
      # N番目(1〜)のフィボナッチ数を返す
      # ans = fib(i)
      # ans = fib_memoize_recursive(i)
      ans = fib_dp(i)
      puts ans
    end
  end

  # 動的計画法（DP）版
  # ※100000番目まではOK。その上はTimeout
  def fib_dp(n)
    return 0 if n == 0
    return 1 if n == 1
    @dp = Array.new(n+1)
    @dp[0] = 0
    @dp[1] = 1
    fib3(n)
  end
  def fib3(n)
    2.upto(n) do |i|
      @dp[i] = @dp[i-1] + @dp[i-2]
    end
    @dp[n]
  end

  # メモ化再帰版
  # ※10000番目でもOK。その上はStackLevelTooDeep。※再帰を使ってるのでDPよりは弱い。
  def fib_memoize_recursive(n)
    @memo = Array.new(n+1)
    @memo[0] = 0
    @memo[1] = 1
    fib2(n)
  end
  def fib2(n)
    return @memo[n] unless @memo[n].nil?

    result = fib2(n-1) + fib2(n-2)
    @memo[n] = result
    result
  end

  # 全探索版
  # ※これだと100番目も無理
  def fib(n)
    return 0 if n == 0
    return 1 if n == 1
    fib(n-1) + fib(n-2)
  end
end

if __FILE__ == $0
  Solver.new.main
end
