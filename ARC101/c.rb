require 'pp'

def gets; ARGF.gets; end

def main
  n, k = gets.split.map(&:to_i)

  minus_cnt = 0
  zero_pos = -1
  last = 0
  candles = []
  gets.split.each_with_index do |c, idx|
    i = c.to_i
    if idx == 0
      if 0 <= i
        candles << i
      end
    elsif i < 0
      candles << i - last
    elsif 0 <= i && last < 0
      candles << -last
      candles << i
    else
      candles << i - last
    end
    last = i

    if i < 0
      minus_cnt += 1
    elsif zero_pos == -1
      zero_pos = idx
    end
    i
  end
  # pp candles
  # puts minus_cnt
  # puts zero_pos

  start_pos = 0
  if k < minus_cnt
    start_pos = minus_cnt - k
  end

  end_pos = candles.length - k
  end_pos = zero_pos if zero_pos < end_pos

  # puts start_pos
  # puts end_pos

  # まずはstart_posからK個点灯
  nega = 0
  posi = 0
  start_pos.upto(start_pos + k - 1) do |idx|
    if idx < zero_pos
      nega += candles[idx]
      posi += candles[idx] * 2
    else
      nega += candles[idx] * 2
      posi += candles[idx]
    end
  end

  min_dist = [nega, posi].min

  # 1つずつずらしながらminを更新
  (start_pos+1).upto(end_pos) do |idx|
    if idx-1 < zero_pos
      nega -= candles[idx-1]
      posi -= candles[idx-1] * 2
    else
      nega -= candles[idx-1] * 2
      posi -= candles[idx-1]
    end

    if idx+k-1 < zero_pos
      nega += candles[idx+k-1]
      posi += candles[idx+k-1] * 2
    else
      nega += candles[idx+k-1] * 2
      posi += candles[idx+k-1]
    end

    min_dist = [nega, posi, min_dist].min
  end

  puts min_dist
end

if __FILE__ == $0
  main
end
