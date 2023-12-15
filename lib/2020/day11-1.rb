module D11P1
  class D11P1
    def run(input)
      map = input.map {|line| line.chomp.split("")}
      map.each do |row|
        row.unshift(".")
        row.push(".")
      end
      new_row = Array.new(map[0].count, ".")
      map.unshift(new_row)
      map.push(new_row)
      processing = true
      while processing
        next_map = tick(map)
        if next_map == map
          processing = false
        end
        map = next_map
      end
      puts "Occupied Seats: #{map.flatten.count("#")}"
    end

    def tick(map)
      next_map = Marshal.load(Marshal.dump(map))
      (1..map.count-2).each do |y|
        (1..map.first.count-2).each do |x|
          section = get_subsction(map, y, x)
          if map[y][x] == "L" and section.flatten.count("#") == 0
            next_map[y][x] = "#"
          elsif map[y][x] == "#" and section.flatten.count("#") >= 5
            next_map[y][x] = "L"
          end
        end
      end
      next_map
    end

    def get_subsction(map, y, x)
      section = []
      ((y-1)..(y+1)).each do |sy|
        section.push map[sy][(x-1)..(x+1)]
      end
      section
    end

    def print_map(map)
      print_map = map.map{|row| row.join("")}
      puts "==============="
      puts print_map.join("\n")
      puts "==============="
    end
  end
end
