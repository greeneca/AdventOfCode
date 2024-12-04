module D4P2
  class D4P2
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
      targets = ["MAS", "SAM"]
      (1..max_y-1).each do |y|
        (1..max_x-1).each do |x|
          if search[Vector[x, y]] == 'A'
            forward = search[Vector[x-1,y+1]] + search[Vector[x,y]] + search[Vector[x+1,y-1]]
            back = search[Vector[x-1,y-1]] + search[Vector[x,y]] + search[Vector[x+1,y+1]]
            if targets.include?(forward) and targets.include?(back)
              count += 1
            end
          end
        end
      end
      puts "Count: #{count}"
    end
  end
end
