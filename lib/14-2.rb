module D14P2
  class D14P2
    def run(input)
      mirror = {}
      rolling = []
      @max_x = input[0].length-1
      @max_y = input.count-1
      input.each_with_index do |line, y|
        line.split("").each_with_index do |rock, x|
          if rock != "."
            mirror[Vector[x,y]] = (rock == "O")
            rolling.push Vector[x,y] if rock == "O"
          end
        end
      end
      target = 1000000000
      cycle = 0
      cache = {}
      while cycle < target
        cycle += 1
        mirror = north(mirror)
        mirror = west(mirror)
        mirror = south(mirror)
        mirror = east(mirror)
        key = mirror.keys.sort{|a,b| a[0] == b[0] ? a[1] <=> b[1] : a[0] <=> b[0]}.to_s
        if cache[key]
          cycle_length = cycle-cache[key]
          repeats = (target-cycle)/cycle_length
          cycle += repeats * cycle_length
        end
        cache[key] = cycle
      end
      sum = 0
      mirror.each_pair do |vector, rolling|
        if rolling
          sum += input.count - vector[1]
        end
      end
      puts "Sum: #{sum}"
    end
    def north(mirror)
      rocks = mirror.keys.sort{|a,b| a[1] <=> b[1]}
      rocks.each do |rock|
        if mirror[rock]
          while rock[1] > 0 and mirror[Vector[rock[0],rock[1]-1]].nil?
            mirror.delete rock
            rock = Vector[rock[0],rock[1]-1]
            mirror[rock] = true
          end
        end
      end
      return mirror
    end
    def west(mirror)
      rocks = mirror.keys.sort{|a,b| a[0] <=> b[0]}
      rocks.each do |rock|
        if mirror[rock]
          while rock[0] > 0 and mirror[Vector[rock[0]-1,rock[1]]].nil?
            mirror.delete rock
            rock = Vector[rock[0]-1,rock[1]]
            mirror[rock] = true
          end
        end
      end
      return mirror
    end
    def south(mirror)
      rocks = mirror.keys.sort{|a,b| b[1] <=> a[1]}
      rocks.each do |rock|
        if mirror[rock]
          while rock[1] < @max_y and mirror[Vector[rock[0],rock[1]+1]].nil?
            mirror.delete rock
            rock = Vector[rock[0],rock[1]+1]
            mirror[rock] = true
          end
        end
      end
      return mirror
    end
    def east(mirror)
      rocks = mirror.keys.sort{|a,b| b[0] <=> a[0]}
      rocks.each do |rock|
        if mirror[rock]
          while rock[0] < @max_x and mirror[Vector[rock[0]+1,rock[1]]].nil?
            mirror.delete rock
            rock = Vector[rock[0]+1,rock[1]]
            mirror[rock] = true
          end
        end
      end
      return mirror
    end
    def print(mirror)
      puts "======================="
      (0..@max_y).each do |y|
        row = ""
        (0..@max_x).each do |x|
          point = Vector[x,y]
          if mirror[point].nil?
            row += "."
          elsif mirror[point]
            row += "O"
          else
            row += "#"
          end
        end
        puts row
      end
    end
  end
end
