module D11P1
  class D11P1
    GRID_SERIAL = 7139
    def run(input)
      @grid = Array.new(300) {Array.new(300, 0)}

      @grid.each_index do |x|
        rack_id = (x+1) +10
        @grid[x].each_index do |y|
          power = rack_id * (y+1)
          power += GRID_SERIAL
          power *= rack_id
          power = power >= 100 ? power.to_s[-3].to_i : 0
          power -= 5
          @grid[x][y] = power
        end
      end

      max = {
        x: 0,
        y: 0,
        power: nil
      }
      (0..@grid.count-3).each do |x|
        (0..@grid.count-3).each do |y|
          power = 0
          @grid[x..x+2].each do |col|
            col[y..y+2].each do |val|
              power += val
            end
          end
          if not max[:power] or power > max[:power]
            max[:x] = x+1
            max[:y] = y+1
            max[:power] = power
          end
        end
      end

      puts "#{max[:x]}, #{max[:y]}: #{max[:power]}"
    end
    def print_grid(x, y)
      ((y-2)..(y+2)).each do |y|
        ((x-2)..(x+2)).each do |x|
          printf "%4d", @grid[x][y]
        end
        print "\n\n"
      end
    end
  end
end
