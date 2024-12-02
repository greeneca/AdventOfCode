module D1P1
  class D1P1
    def run(input)
      left = []
      right = []
      input.each do |pair|
        pair = pair.split('   ')
        left.push(pair[0])
        right.push(pair[1])
      end
      left.sort!()
      right.sort!()
      distance = 0
      left.zip(right).each do |pair|
        distance += (pair[0].to_i - pair[1].to_i).abs
      end
      puts "Distance: #{distance}"
    end
  end
end
