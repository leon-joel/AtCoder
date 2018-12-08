require 'pp'

def gets; ARGF.gets; end

# -> 食べたパテ数、食べきっていない場合は残り枚数
def eat(lv, to_eat)
  # lv0
  if lv == 0
    return [1, to_eat-1]
  end

  # 端
  if to_eat == 1
    return 0, 0
  end

  # 前レベルその1
  pate, rest = eat(lv-1, to_eat-1)
  return pate, 0 if rest == 0

  # 真ん中
  return pate+1, 0 if rest == 1

  # 前レベルその2
  pate += 1
  rest -= 1
  p, rest = eat(lv-1, rest)
  pate += p

  return pate, 0 if rest == 0

  # 端
  return pate, 0 if rest == 1

  # このレベルでは食べきれなかった
  [pate, rest-1]
end

def eat2(lv, to_eat)
  # lv0
  if lv == 0
    return [1, to_eat-1]
  end

  total, pate = burger_info(lv)
  # 食べ尽くせる
  if total <= to_eat
    return [pate, to_eat - total]
  end

  # 残る -> こまぎれに考える
  if to_eat == 1
    return 0, 0
  end

  # 前レベルその1
  pate, rest = eat2(lv-1, to_eat-1)
  return pate, 0 if rest == 0

  # 真ん中
  return pate+1, 0 if rest == 1

  # 前レベルその2
  pate += 1
  rest -= 1
  p, rest = eat2(lv-1, rest)
  pate += p

  return pate, 0 if rest == 0

  # 端
  return pate, 0 if rest == 1

  # このレベルでは食べきれなかった
  [pate, rest-1]
end

# total, pate
def burger_info(lv)
  # lv total pate
  # 0      1    1
  # 1      5    3
  # 2     13    7
  # 3 13*2+3 7*2+1
  #

  return [1, 1] if lv == 0

  total = 1
  pate = 1
  lv.times do |l|
    total = total * 2 + 3
    pate = pate * 2 + 1
  end
  [total, pate]
end

def main
  n, x = gets.split.map(&:to_i)

  pate, _ = eat2(n, x)

  puts pate
end

if __FILE__ == $0
  main
end
