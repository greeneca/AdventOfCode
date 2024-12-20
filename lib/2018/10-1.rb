module D10P1
  class D10P1
    def run(input)
      @lights = []
      @min = [nil, nil]
      @max = [nil, nil]
      input.each do |line|
        match_data = /position=<(.*)> velocity=<(.*)>/.match(line)
        x, y = match_data[1].split(", ").map {|coordinate| coordinate.to_i}
        dx, dy = match_data[2].split(", ").map {|coordinate| coordinate.to_i}
        @lights.push(Light.new([x, y], [dx, dy]))
        check_min_max(x, y)
      end

      time = 0
      while true
        @min = [nil, nil]
        @max = [nil, nil]
        @lights.each do |light|
          x, y = light.tick
          check_min_max(x, y)
        end
        time += 1
        if @max[0] - @min[0] < @lights.count/2 and @max[1] - @min[1] < @lights.count/2
          puts "#{time}: #{@min}, #{@max}"
            print_lights
          STDIN.read(1)
        end
      end
      puts "Done"
    end
    def check_min_max(x, y)
      @min[0] = x if !@min[0] or x < @min[0]
      @max[1] = y if !@max[1] or y > @max[1]
      @max[0] = x if !@max[0] or x > @max[0]
      @min[1] = y if !@min[1] or y < @min[1]
    end
    def print_lights
      x = @max[0] - @min[0] + 10
      y = @max[1] - @min[1] + 10
      field = Array.new(x) {Array.new(y, ".")}
      x_adj = @min[0].abs - 5
      y_adj = @min[1].abs - 5
      @lights.each do |light|
        field[light.x - x_adj][light.y - y_adj]  = "#"
      end
      field[0].each_index do |idx|
        print "|"
        field.each do |col|
          print col[idx]
        end
        print "|\n"
      end
    end

  end
  class Light

    def initialize(position, velocity)
      @position = position
      @velocity = velocity
      [0, 1] .each do |c|
        if position[c] > 0 and velocity[c] > 0 or position[c] < 0 and velocity[c] < 0
          puts "BAD"
        end
      end
    end

    def tick
      @position[0] += @velocity[0]
      @position[1] += @velocity[1]
      @position
    end

    def x
      @position[0]
    end

    def y
      @position[1]
    end
  end
end
