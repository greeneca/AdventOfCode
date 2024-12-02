module D1P2
  class D1P2
    def run(input)
      left = []
      right = []
      input.each do |pair|
        pair = pair.split('   ')
        left.push(pair[0])
        right.push(pair[1])
      end
      right.sort!()
      score = 0
      left.each do |l|
        score += l.to_i*right.count(l)
      end
      puts "Score: #{score}"
    end
  end
end
