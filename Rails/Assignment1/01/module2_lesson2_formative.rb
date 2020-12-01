arr = (1..10000).to_a
p arr.select { |e| e % 3 == 0 }.reject { |e| e < 5000 }.sort.reverse