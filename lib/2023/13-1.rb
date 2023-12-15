module D13P1
  class D13P1
    def run(input)
      sum = 0
      pattern = []
      loop do 
        line = input.shift
        break if line.nil?
        if line.empty?
          sum += get_value(pattern)
          pattern = []
        else
          pattern.push line
        end
      end
      sum += get_value(pattern)
      puts "Sum: #{sum}"
    end
    def get_value(pattern, no_pivot = false)
      pattern.each_with_index do |line,idx| 
        if pattern[idx+1] and line == pattern[idx+1]
          a, b, = idx, idx+1
          matching = true
          while a >= 0 and b < pattern.count
            matching = pattern[a] == pattern[b]
            break unless matching
            a -= 1
            b += 1
          end
          return 100*(idx+1) if matching 
        end
      end
      return 0 if no_pivot
      pivoted = Array.new(pattern[0].length, "")
      pattern.each do |line|
        line.split("").each_with_index do |point, idx|
          pivoted[idx] += point
        end
      end
      return get_value(pivoted, true)/100
    end
  end
end
