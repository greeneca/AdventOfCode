module D11P2
  class D11P2
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
          seats = get_visable_seats(map, y, x)
          if map[y][x] == "L" and seats.count("#") == 0
            next_map[y][x] = "#"
          elsif map[y][x] == "#" and seats.count("#") >= 5
            next_map[y][x] = "L"
          end
        end
      end
      next_map
    end

    def get_visable_seats(map, y, x)
      seats = []
      #up
      (1..y).each do |d|
        sy = y-d
        break if check_seat(map, seats, sy, x)
      end
      #up-left
      (1..y).each do |d|
        sy = y-d
        sx = x-d
        break if sx < 0
        break if check_seat(map, seats, sy, sx)
      end
      #up-right
      (1..y).each do |d|
        sy = y-d
        sx = x+d
        break if sx > map.first.count-1
        break if check_seat(map, seats, sy, sx)
      end
      #down
      (y+1..map.count-1).each do |sy|
        break if check_seat(map, seats, sy, x)
      end
      #down-left
      (y+1..map.count-1).each_with_index do |sy,i|
        sx = x-(i+1)
        break if sx < 0
        break if check_seat(map, seats, sy, sx)
      end
      #down-left
      (y+1..map.count-1).each_with_index do |sy,i|
        sx = x+(i+1)
        break if sx > map.first.count-1
        break if check_seat(map, seats, sy, sx)
      end
      #left
      (1..x).each do |d|
        sx = x-d
        break if check_seat(map, seats, y, sx)
      end
      #right
      (x+1..map[0].count-1).each do |sx|
        break if check_seat(map, seats, y, sx)
      end
      seats
    end

    def check_seat(map, seats, y, x)
      if map[y][x] != "."
        seats.push(map[y][x])
        return true
      end
      false
    end

    def print_map(map)
      print_map = map.map{|row| row.join("")}
      puts "==============="
      puts print_map.join("\n")
      puts "==============="
    end
  end
end
