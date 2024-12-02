module D2P2
  class D2P2
    def run(input)
      safe_count = 0
      input.each do |report|
        levels = report.split(' ').map(&:to_i)
        if is_safe(levels)
          safe_count += 1
        else
          (0..levels.length-1).each do |idx|
            dampened = levels.dup
            dampened.delete_at(idx)
            if is_safe(dampened)
              safe_count += 1
              break
            end
          end
        end
      end
      puts "Safe: #{safe_count}"
    end

    def is_safe(levels)
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
      return safe
    end
  end
end
