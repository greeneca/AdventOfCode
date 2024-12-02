module D2P1
  class D2P1
    def run(input)
      safe_count = 0
      input.each do |report|
        levels = report.split(' ').map(&:to_i)
        prev = levels[0]
        safe = true
        dir = nil
        (1..levels.length-1).each do |idx|
          diff = levels[idx] - prev
          if diff.abs > 3 or diff == 0
            safe = false
            break
          end
          if dir.nil?
            dir = diff/diff.abs
          elsif dir != diff/diff.abs
            safe = false
            break
          end
          prev = levels[idx]
        end
        safe_count += 1 if safe
      end
      puts "Safe: #{safe_count}"
    end
  end
end
