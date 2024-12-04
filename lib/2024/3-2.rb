module D3P2
  class D3P2
    def run(input)
      sum = 0
      enabled = true
      input.each do |line|
        regexp = /mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)/
        match  = regexp.match(line)
        offset = 0
        while match
          if match[0] == "do()"
            enabled = true
          elsif match[0] == "don't()"
            enabled = false
          else
            sum += match[1].to_i*match[2].to_i if enabled
          end
          offset = match.end(0)
          match = regexp.match(line, offset)
        end
      end
      puts "Sum: #{sum}"
    end
  end
end
