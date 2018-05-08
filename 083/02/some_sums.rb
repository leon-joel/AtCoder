upper_lim, sum_min, sum_max = gets.split.map(&:to_i)

sum_range = (sum_min..sum_max)

sum_of_n = 0

1.upto upper_lim do |n|
  dsum = 0
  d = n
  loop do
    if d < 10
      dsum += d
      break
    end

    d, m = d.divmod(10)
    dsum += m
  end

  if sum_range.include?(dsum)
    sum_of_n += n
  end
end

puts sum_of_n
