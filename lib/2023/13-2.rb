module D13P2
  class D13P2
    def run(input)
      sum = 0
      pattern = []
      loop do 
        line = input.shift
        break if line.nil?
        if line.empty?
          value = get_value(pattern)
          sum += value
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
        if pattern[idx+1] and compare(line, pattern[idx+1]) <= 1
          a, b, = idx, idx+1
          difference = 0
          while a >= 0 and b < pattern.count
            difference += compare(pattern[a], pattern[b])
            break if difference > 1
            a -= 1
            b += 1
          end
          return 100*(idx+1) if difference == 1
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
    def compare(a, b)
      a = a.split("")
      b = b.split("")
      difference = 0
      a.zip(b).each {|a, b| difference += 1 if a != b }
      return difference
    end
  end
end
