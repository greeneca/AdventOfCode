module D4P1
  class D4P1
    def run(input)
      search = {}
      max_x = 0
      max_y = 0
      input.each_with_index do |line, y|
        max_y = y if y > max_y
        line.split('').each_with_index do |char, x|
          max_x = x if x > max_x
          search[Vector[x, y]] = char
        end
      end
      count = 0
      targets = ["XMAS", "SAMX"]
      (0..max_y).each do |y|
        (0..max_x).each do |x|
          if x <= max_x - 3
            word = search[Vector[x, y]] + search[Vector[x+1, y]] + search[Vector[x+2, y]] + search[Vector[x+3, y]]
            if targets.include?(word)
              count += 1
              #puts "Right: #{Vector[x, y]}: #{word}"
            end
          end
          if y <= max_y - 3
            word = search[Vector[x, y]] + search[Vector[x, y+1]] + search[Vector[x, y+2]] + search[Vector[x, y+3]]
            if targets.include?(word)
              count += 1
              #puts "Down: #{Vector[x, y]}: #{word}"
            end
          end
          if x <= max_x - 3 and y <= max_y - 3
            word = search[Vector[x, y]] + search[Vector[x+1, y+1]] + search[Vector[x+2, y+2]] + search[Vector[x+3, y+3]]
            if targets.include?(word)
              count += 1
              #puts "Down Right: #{Vector[x, y]}: #{word}"
            end
          end
          if x >= 3 and y <= max_y - 3
            word = search[Vector[x, y]] + search[Vector[x-1, y+1]] + search[Vector[x-2, y+2]] + search[Vector[x-3, y+3]]
            if targets.include?(word)
              count += 1
              #puts "Down Left: #{Vector[x, y]}: #{word}"
            end
          end
        end
      end
      puts "Count: #{count}"
    end
  end
end
