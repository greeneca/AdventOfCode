module D11P2
  class D11P2
    GRID_SERIAL = 7139
    SIZE = 300
    def run(input)
      @grid = Array.new(SIZE+1) {Array.new(SIZE+1, 0)}

      (1..SIZE).each do |x|
        rack_id = (x) +10
        (1..SIZE).each do |y|
          power = rack_id * (y)
          power += GRID_SERIAL
          power *= rack_id
          power = power/100 % 10
          power -= 5
          @grid[x][y] = power + @grid[x-1][y] + @grid[x][y-1] - @grid[x-1][y-1]
        end
      end

      max = {
        x: 0,
        y: 0,
        s: 0,
        power: 0
      }
      (1..SIZE).each do |s|
        (s..SIZE).each do |x|
          (s..SIZE).each do |y|
            power = @grid[x][y] - @grid[x-s][y] - @grid[x][y-s] + @grid[x-s][y-s]
            if power > max[:power]
              max[:x] = x - s + 1
              max[:y] = y - s + 1
              max[:s] = s
              max[:power] = power
            end
          end
        end
      end

      puts "#{max[:x]}, #{max[:y]}, #{max[:s]}: #{max[:power]}"
    end
  end
end
