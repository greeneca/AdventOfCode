module D1P1
  class D1P1
    def run(input)
      input.map! {|x| x.to_i}
      prev = nil
      inc = 0
      input.each do |depth|
        if prev and depth > prev
          inc += 1
        end
        prev = depth
      end
      puts "Incresed #{inc} times"
    end
  end
end

module D1P2
  class D1P2
    def run(input)
      input.map! {|x| x.to_i}
      window = []
      prev = nil
      inc = 0
      input.each do |depth|
        window.push(depth)
        if window.count >= 3
          if prev and window.sum > prev
            inc += 1
          end
          prev = window.sum
          window.shift
        end
      end
      puts "Incresed #{inc} times"
    end
  end
end
