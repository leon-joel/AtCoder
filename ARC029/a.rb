require 'pp'

def gets; ARGF.gets; end

def main
  num = ARGF.gets.to_i

  meats = Array.new(num)
  num.times do |i|
    meats[i] = gets.to_i
  end
  # pp meats

  total_time = meats.inject(0, :+)
  # pp total_time

  min_sum = 200

  # bit mask の生成
  0.upto((1 << num) - 1) do |mask|
    sum1 = 0
    # 各bitを下から舐める
    0.upto(num-1) do |i|
      # ビットが立っている＝鉄板1で焼く
      if mask[i] == 1
        sum1 += meats[i]
      end
    end

    # 鉄板2の消費時間
    sum2 = total_time - sum1

    sum = [sum1, sum2].max
    min_sum = sum if sum < min_sum
  end

  puts min_sum
end

if __FILE__ == $0
  main
end
